//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Anvar Rahimov on 03.01.2023.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}
