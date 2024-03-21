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
        URL(string: "http://158.160.60.2/")
    }

    var path: String {
        switch self {
        case .login: "api/v1/auth/token/login/"
        case .createUser: "api/v1/users/"
        case .friends: "api/v1/friends/"
        case .resetPassword: "api/v1/users/reset_password/"
        case .newPassword: "api/v1/users/reset_password_confirm/"
        case .interests: "api/v1/interests/"
        }
    }

    var url: URL? {
        switch self {
        case .login: return URL(string: Endpoint.login.path, relativeTo: baseURL)
        case .createUser: return URL(string: Endpoint.createUser.path, relativeTo: baseURL)
        case .friends: return URL(string: Endpoint.friends.path, relativeTo: baseURL)
        case .resetPassword: return URL(string: Endpoint.resetPassword.path, relativeTo: baseURL)
        case .newPassword: return URL(string: Endpoint.newPassword.path, relativeTo: baseURL)
        case .interests: return URL(string: Endpoint.interests.path, relativeTo: baseURL)
        }
    }
}
