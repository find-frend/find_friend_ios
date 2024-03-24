import Foundation

protocol NetworkRequestProtocol {
    var endpoint: Endpoint { get }
    var httpMethod: HttpMethod { get }
    var token: String? { get }
    var dto: Encodable? { get }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
