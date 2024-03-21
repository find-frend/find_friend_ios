//
//  Endpoints.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//


import Foundation

enum Endpoints {

    case login
    case createUser
    case getFriends
    case resetPassword
    case newPassword
    case getInterests

    static let baseURL = URL(string: "http://158.160.60.2/")!

    var path: String {
        switch self {
        case .login: return "api/v1/auth/token/login/"
        case .createUser: return "/api/v1/users/"
        case .getFriends: return "/api/v1/friends/"
        case .resetPassword: return "/api/v1/users/reset_password/"
        case .newPassword: return "/api/v1/users/reset_password_confirm/"
        case .getInterests: return "/api/v1/interests/"
        }
    }

    var url: URL? {
        switch self {
        case .login: return URL(string: Endpoints.login.path, relativeTo: Endpoints.baseURL)
        case .createUser: return URL(string: Endpoints.createUser.path, relativeTo: Endpoints.baseURL)
        case .getFriends: return URL(string: Endpoints.getFriends.path, relativeTo: Endpoints.baseURL)
        case .resetPassword: return URL(string: Endpoints.resetPassword.path, relativeTo: Endpoints.baseURL)
        case .newPassword: return URL(string: Endpoints.newPassword.path, relativeTo: Endpoints.baseURL)
        case .getInterests: return URL(string: Endpoints.getInterests.path, relativeTo: Endpoints.baseURL)
        }
    }
}
