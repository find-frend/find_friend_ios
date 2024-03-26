//
//  CreateUserDto.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct CreateUserRequestDto: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case email, password
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
