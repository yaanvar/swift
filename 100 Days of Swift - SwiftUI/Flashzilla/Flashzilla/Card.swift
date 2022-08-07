//
//  Card.swift
//  Flashzilla
//
//  Created by Anvar Rahimov on 07.08.2022.
//

import Foundation

struct Card: Codable, Identifiable {
    let id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
