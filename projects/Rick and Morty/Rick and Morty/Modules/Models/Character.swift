//
//  Character.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import Foundation
import UIKit

struct Character: Codable {
    let name: String
    let id: Int
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let location: Location
}
