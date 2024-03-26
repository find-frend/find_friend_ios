//
//  NewPasswordDto.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct NewPasswordDto: Codable {
    let token: String
    let password: String
}
