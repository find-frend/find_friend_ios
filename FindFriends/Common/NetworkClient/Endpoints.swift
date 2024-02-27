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

    static let baseURL = URL(string: "http://213.189.221.246/")!

    var path: String {
        switch self {
        case .login: return "api/v1/auth/token/login/"
        case .createUser: return "/api/v1/users/"
        case .getFriends: return "/api/v1/friends/"
        }
    }

    var url: URL? {
        switch self {
        case .login: return URL(string: Endpoint.login.path, relativeTo: Endpoint.baseURL)
        case .createUser: return URL(string: Endpoint.createUser.path, relativeTo: Endpoint.baseURL)
        case .getFriends: return URL(string: Endpoint.getFriends.path, relativeTo: Endpoint.baseURL)
        }
    }
}
