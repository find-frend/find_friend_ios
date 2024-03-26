//
//  UserLoginDto.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct LoginRequestDto: Encodable {
    let email: String
    let password: String
}
