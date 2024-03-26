import Foundation

protocol NetworkRequestProtocol {
    var endpoint: Endpoint { get }
    var httpMethod: HttpMethod { get }
    var token: String? { get }
    var body: Encodable? { get }
}

extension NetworkRequestProtocol {
    var token: String? {
        OAuthTokenStorage.shared.token
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
