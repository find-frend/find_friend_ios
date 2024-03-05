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
    case getFriends
    case resetPassword
    case newPassword

    static let baseURL = URL(string: "http://158.160.60.2/")!

    var path: String {
        switch self {
        case .login: return "api/v1/auth/token/login/"
        case .createUser: return "/api/v1/users/"
        case .getFriends: return "/api/v1/friends/"
        case .resetPassword: return "/api/v1/users/reset_password/"
        case .newPassword: return "/api/v1/users/reset_password_confirm/"
        }
    }

    var url: URL? {
        switch self {
        case .login: return URL(string: Endpoint.login.path, relativeTo: Endpoint.baseURL)
        case .createUser: return URL(string: Endpoint.createUser.path, relativeTo: Endpoint.baseURL)
        case .getFriends: return URL(string: Endpoint.getFriends.path, relativeTo: Endpoint.baseURL)
        case .resetPassword: return URL(string: Endpoint.resetPassword.path, relativeTo: Endpoint.baseURL)
        case .newPassword: return URL(string: Endpoint.newPassword.path, relativeTo: Endpoint.baseURL)
        }
    }
}
