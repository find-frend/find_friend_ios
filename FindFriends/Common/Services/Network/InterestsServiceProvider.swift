//
//  InterestsServiceProvider.swift
//  FindFriends
//
//  Created by Vitaly on 05.03.2024.
//

import Foundation

struct InterstsRequest: NetworkRequest {
    let httpMethod: HttpMethod = .get
    let endpoint = Endpoint.getInterests.url
    let dto: Encodable? = nil
    let token: String?
}

protocol InterestsServiceProviderProtocol {
    func getInterests(completion: @escaping (Result<[InterestsdDto], Error>) -> Void)
}

final class InterestsServiceProvider: InterestsServiceProviderProtocol {

    private let networkClient: NetworkClient
    private let oAuthTokenStorage: OAuthTokenStorageProtocol

    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        oAuthTokenStorage: OAuthTokenStorageProtocol = OAuthTokenStorage.shared
    ) {
        self.networkClient = networkClient
        self.oAuthTokenStorage = oAuthTokenStorage
    }

    /// Функция возвращает список друзей у текущего пользователя
    func getInterests(completion: @escaping (Result<[InterestsdDto], Error>) -> Void) {
        print("call getInterests()")
        guard let token = oAuthTokenStorage.token else {
            print("No token. Error.")
            return
        }
        let request = InterstsRequest(token: token)
        networkClient.send(request: request, type: [InterestsdDto].self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

}
