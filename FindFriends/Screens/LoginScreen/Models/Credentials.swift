//
//  Credentials.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import Foundation

struct Credentials {
    let email: String
    let password: String

    var toLoginRequestDto: LoginRequestDto {
        LoginRequestDto(email: email, password: password)
    }

    static var empty: Credentials = Credentials(email: "", password: "")
}
