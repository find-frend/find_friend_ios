//
//  FriendsNetworkService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

protocol FriendsServiceProviderProtocol {
    func getFriends(completion: @escaping (Result<[FriendDto], Error>) -> Void)
}

final class FriendsServiceProvider: FriendsServiceProviderProtocol {

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
    func getFriends(completion: @escaping (Result<[FriendDto], Error>) -> Void) {
        guard let token = oAuthTokenStorage.token else { return }
        let request = GetFriendsRequest(token: token)
        networkClient.send(request: request, type: [FriendDto].self) { result in
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
