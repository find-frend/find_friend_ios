//
//  ProfileRequest.swift
//  FindFriends
//
//  Created by Victoria Isaeva on 22.03.2024.
//

import Foundation

struct ProfileRequest: NetworkRequest {
    let httpMethod: HttpMethod = .get
    let endpoint = Endpoint.getUser.url
    let dto: Encodable?
    let token: String? = nil
}
