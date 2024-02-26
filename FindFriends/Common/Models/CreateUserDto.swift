//
//  CreateUserDto.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct CreateUserRequestDto : Codable {
    let first_name: String
    let last_name: String
    let email: String
    let password: String
}

struct CreateUserResponceDto : Codable {
    let first_name: String
    let last_name: String
    let email: String
}
