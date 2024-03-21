//
//  CreateUserRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct CreateUserRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .post
    let endpoint: Endpoint = .createUser
    let dto: Encodable?
    let token: String? = nil
}
