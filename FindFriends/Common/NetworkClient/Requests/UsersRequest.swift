//
//  CreateUserRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct UsersRequest: NetworkRequestProtocol {
    // get - все пользователи
    // post - создать пользователя при регистрации 
    let httpMethod: HttpMethod
    let endpoint: Endpoint = .createUser
    let body: Encodable?
}
