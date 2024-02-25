//
//  FriendsNetworkService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct GetFriendsRequest: NetworkRequest {
    var httpMethod: HttpMethod = .get
    
    var dto: Encodable?
    
    var token: String = ""
    var endpoint: URL? = URL(string: "http://213.189.221.246/api/v1/friends/")
}

protocol FriendsServiceProviderProtocol {
    func getFriends(_ completion: @escaping (Result<[FriendDto], Error>) -> Void)
}

final class FriendsServiceProvider: FriendsServiceProviderProtocol {
    
    let networkClient: NetworkClient
    

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    

    
    /// Функция функция возвразает список друзей у текущего пользователя
    func getFriends(_ completion: @escaping (Result<[FriendDto], Error>) -> Void) {
        
        var getFriendsRequest = GetFriendsRequest()
        let authToken = OAuthTokenStorage().token ?? ""
        print("authToken  = \(authToken)")
        getFriendsRequest.token = authToken
        networkClient.send(request: getFriendsRequest , type: [FriendDto].self)  { result in
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
