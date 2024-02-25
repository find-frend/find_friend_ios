//
//  UserLoginDto.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct LoginRequestDto : Codable {
    let password: String
    let email: String
}

struct LoginResponceDto : Codable {
    let auth_token: String
}
