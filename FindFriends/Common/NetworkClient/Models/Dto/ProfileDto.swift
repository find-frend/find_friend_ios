//
//  ProfileDto.swift
//  FindFriends
//
//  Created by Victoria Isaeva on 22.03.2024.
//

import Foundation

struct ProfileDto: Codable {
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
    }
}
