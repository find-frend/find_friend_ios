//
//  ValidateCode.swift
//  FindFriends
//
//  Created by Вадим Шишков on 26.03.2024.
//

import Foundation

struct ValidateCodeRequest: NetworkRequestProtocol {
    let httpMethod: HttpMethod = .post
    let endpoint = Endpoint.validateToken
    let body: Encodable?
}
