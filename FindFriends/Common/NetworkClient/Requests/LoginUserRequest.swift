//
//  LoginUserRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct LoginUserRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .post
    let endpoint: Endpoint = .login
    let body: Encodable?
}
