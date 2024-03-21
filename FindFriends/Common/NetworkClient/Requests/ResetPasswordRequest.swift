//
//  ResetPasswordRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct ResetPasswordRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .post
    let endpoint: Endpoint = .resetPassword
    let dto: Encodable?
    let token: String? = nil
}
