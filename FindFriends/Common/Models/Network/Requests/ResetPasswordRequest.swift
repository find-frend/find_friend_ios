//
//  ResetPasswordRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct ResetPasswordRequest: NetworkRequest {
    let httpMethod: HttpMethod = .post
    let endpoint = Endpoint.resetPassword.url
    let dto: Encodable?
    let token: String? = nil
}
