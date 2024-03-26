//
//  CreateUserResponse.swift
//  FindFriends
//
//  Created by Вадим Шишков on 26.03.2024.
//

import Foundation

struct CreateUserResponseDto: Decodable {
    let firstName: String
    let lastName: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
    }
}
