//
//  NewPasswordRequest.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct NewPasswordRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .post
    let endpoint: Endpoint = .newPassword
    let body: Encodable?
}
