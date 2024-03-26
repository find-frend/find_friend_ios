//
//  LoginResponse.swift
//  FindFriends
//
//  Created by Вадим Шишков on 26.03.2024.
//

import Foundation

struct LoginResponseDto: Decodable {
    let authToken: String

    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
    }
}
