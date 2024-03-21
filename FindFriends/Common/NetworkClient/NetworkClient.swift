import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int, Data)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
}

protocol NetworkClient {
    @discardableResult
    func send(
        request: NetworkRequestProtocol,
        onResponse: @escaping (Result<Data, NetworkClientError>) -> Void
    ) -> NetworkTask?

    @discardableResult
    func send<T: Decodable>(
        request: NetworkRequestProtocol,
        type: T.Type,
        onResponse: @escaping (Result<T, NetworkClientError>) -> Void
    ) -> NetworkTask?
}

struct DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }
    
    @discardableResult
    func send(
        request: NetworkRequestProtocol,
        onResponse: @escaping (Result<Data, NetworkClientError>) -> Void
    ) -> NetworkTask? {
        
        guard let urlRequest = create(request: request) else { return nil }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                onResponse(.failure(.urlRequestError(error)))
                return
            }
            
            guard let code = (response as? HTTPURLResponse)?.statusCode else { return }
            
            if let data = data {
                if 200..<300 ~= code {
                    onResponse(.success(data))
                } else {
                    onResponse(.failure(.httpStatusCode(code, data)))
                }
            } else {
                onResponse(.failure(.urlSessionError))
            }
        }

        task.resume()
        return DefaultNetworkTask(dataTask: task)
    }

    @discardableResult
    func send<T: Decodable>(
        request: NetworkRequestProtocol,
        type: T.Type,
        onResponse: @escaping (Result<T, NetworkClientError>) -> Void
    ) -> NetworkTask? {
        
        return send(request: request) { result in
            switch result {
            case let .success(data):
                self.parse(data: data, type: type, onResponse: onResponse)
            case let .failure(error):
                onResponse(.failure(error))
            }
        }
    }
    
    private func create(request: NetworkRequestProtocol) -> URLRequest? {
        guard let endpoint = request.endpoint else {
            assertionFailure("Empty endpoint")
            return nil
        }

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue

        if let token = request.token {
            urlRequest.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let dto = request.dto,
           let dtoEncoded = try? encoder.encode(dto) {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = dtoEncoded
        }

        return urlRequest
    }

    private func parse<T: Decodable>(data: Data, type _: T.Type, onResponse: @escaping (Result<T, NetworkClientError>) -> Void) {
        do {
            let response = try decoder.decode(T.self, from: data)
            onResponse(.success(response))
        } catch {
            onResponse(.failure(.parsingError))
        }
    }
}
