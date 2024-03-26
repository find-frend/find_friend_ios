//
//  GetFriendsRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct FriendsRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .get
    let endpoint: Endpoint = .friends
    let body: Encodable? = nil
}
