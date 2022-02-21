//
//  SetCard.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import Foundation

struct SetCard: Matchable {
    let shape: Version
    let fill: Version
    let color: Version
    let number: Version
    
    enum Version: Int, CaseIterable {
        case v1 = 1
        case v2 = 2
        case v3 = 3
    }
    
    static func match(cards: [SetCard]) -> Bool {
        guard cards.count == 3 else {return false}
        let sum = [
        cards.reduce(0, { $0 + $1.number.rawValue}),
        cards.reduce(0, { $0 + $1.color.rawValue}),
        cards.reduce(0, { $0 + $1.shape.rawValue}),
        cards.reduce(0, { $0 + $1.fill.rawValue})
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}
