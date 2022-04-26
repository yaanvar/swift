//
//  Character.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//


//На экране детальной информации о персонаже должно отображаться имя, раса, пол, статус, аватарка, последнее известное местоположение, кол-во эпизодов, в которых упоминался данный персонаж.

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
