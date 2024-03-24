//
//  FrindsModel.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct FriendDto: Codable {
    let id: Int
    let initiator: Int
    let friend: Int
    let isAdded: Bool

    enum CodingKeys: String, CodingKey {
        case id, initiator, friend
        case isAdded = "is_added"
    }
}
