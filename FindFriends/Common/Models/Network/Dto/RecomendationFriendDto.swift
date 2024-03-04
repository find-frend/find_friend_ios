//
//  SearchFriend.swift
//  FindFriends
//
//  Created by Вадим Шишков on 29.02.2024.
//

import Foundation

struct RecomendationFriendDto: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let avatar: String
    let purpose: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, age, avatar, purpose
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
