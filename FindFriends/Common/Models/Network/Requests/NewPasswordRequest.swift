//
//  NewPasswordRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct NewPasswordRequest: NetworkRequest {
    let httpMethod: HttpMethod = .post
    let endpoint = Endpoint.newPassword.url
    let dto: Encodable?
    let token: String? = nil
}
