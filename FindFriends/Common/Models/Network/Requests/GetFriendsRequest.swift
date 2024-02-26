//
//  GetFriendsRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct GetFriendsRequest: NetworkRequest {
    let httpMethod: HttpMethod = .get
    let endpoint = Endpoint.getFriends.url
    let dto: Encodable? = nil
    let token: String?
}
