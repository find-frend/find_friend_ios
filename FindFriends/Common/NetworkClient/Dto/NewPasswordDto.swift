//
//  NewPasswordDto.swift
//  FindFriends
//
//  Created by Artem Novikov on 28.02.2024.
//

import Foundation

struct NewPasswordDto: Codable {
    let uid: String
    let token: String
    let new_password: String
}
