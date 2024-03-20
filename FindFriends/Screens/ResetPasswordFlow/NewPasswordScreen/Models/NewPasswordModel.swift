//
//  NewPasswordModel.swift
//  FindFriends
//
//  Created by Artem Novikov on 27.02.2024.
//

import Foundation

struct NewPasswordModel {
    let password: String
    let passwordConfirmation: String

    static let empty = NewPasswordModel(password: "", passwordConfirmation: "")
}
