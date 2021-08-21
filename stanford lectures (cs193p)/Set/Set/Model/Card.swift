//
//  Card.swift
//  Set
//
//  Created by Anvar Rahimov on 21.08.2021.
//

import Foundation

struct Card {
    var isSelected: Bool = false
    var isMatched: Bool = false
    
    let symbol: Version
    let texture: Version
    let color: Version
    let quantityOfSymbols: Version
    
    enum Version: Int {
        case v1 = 1
        case v2 = 2
        case v3 = 3
    }
}
