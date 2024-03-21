//
//  InterestsDto.swift
//  FindFriends
//
//  Created by Vitaly on 05.03.2024.
//

import Foundation

struct InterestsdDto: Codable {
    let id: Int
    let name: String
    
    init(_ dto: InterestsdDto) {
        self.id = dto.id
        self.name = dto.name
    }
}
