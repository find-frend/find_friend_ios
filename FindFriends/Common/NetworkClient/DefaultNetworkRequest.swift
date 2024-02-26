import Foundation

struct DefaultNetworkRequest: NetworkRequest {
    var token: String
    var endpoint: URL?
    var httpMethod: HttpMethod
    var dto: Encodable?

    init(endpoint: URL, httpMethod: HttpMethod = .get, token: String = "", dto: Encodable? = nil) {
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.dto = dto
        self.token = ""
    }
}
