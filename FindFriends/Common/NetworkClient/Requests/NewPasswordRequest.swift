//
//  NewPasswordRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct NewPasswordRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .post
    let endpoint = Endpoints.newPassword.url
    let dto: Encodable?
    let token: String? = nil
}
