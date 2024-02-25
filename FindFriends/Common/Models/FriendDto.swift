//
//  FrindsModel.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import Foundation

struct FriendDto : Codable {
    let id: Int
    let initiator: Int
    let friend: Int
    let is_added: Bool
}
