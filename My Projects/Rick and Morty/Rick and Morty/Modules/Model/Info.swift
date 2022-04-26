//
//  Info.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 26.04.2022.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
