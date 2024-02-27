//
//  LoginUserRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct LoginUserRequest: NetworkRequest {
    let httpMethod: HttpMethod = .post
    let endpoint = Endpoints.login.url
    let dto: Encodable?
    let token: String? = nil
}
