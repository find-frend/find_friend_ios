//
//  LoginModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct LoginModel {
    let email: String
    let password: String

    var toLoginRequestDto: LoginRequestDto {
        LoginRequestDto(email: email, password: password)
    }
}
