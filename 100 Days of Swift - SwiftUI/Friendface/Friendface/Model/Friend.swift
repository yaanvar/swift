//
//  Friend.swift
//  Friendface
//
//  Created by Anvar Rahimov on 16.07.2022.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

