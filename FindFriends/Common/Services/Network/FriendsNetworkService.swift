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

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func getFriends(completion: @escaping (Result<[FriendDto], Error>) -> Void) {
        let request = FriendsRequest()
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
