//
//  Endpoints.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//


import Foundation

enum Endpoint {

    case login
    case createUser
    case friends
    case resetPassword
    case newPassword
    case interests

    var baseURL: URL? {
        URL(string: "http://158.160.60.2/api/v1/")
    }

    var path: String {
        switch self {
        case .login: "auth/token/login/"
        case .createUser: "users/"
        case .friends: "friends/"
        case .resetPassword: "users/reset_password/"
        case .newPassword: "users/reset_password_confirm/"
        case .interests: "interests/"
        }
    }

    var url: URL? {
        URL(string: path, relativeTo: baseURL)
    }
}
