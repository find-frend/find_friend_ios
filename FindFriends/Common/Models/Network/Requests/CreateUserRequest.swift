//
//  CreateUserRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct CreateUserRequest: NetworkRequest {
    let httpMethod: HttpMethod = .post
    let endpoint = Endpoints.createUser.url
    let dto: Encodable?
    let token: String? = nil
}
