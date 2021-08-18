//
//  SetGame.swift
//  Set
//
//  Created by Anvar Rahimov on 17.08.2021.
//

import Foundation
import SwiftUI

struct SetGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isChoosed,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex
        }
    }
    
    
    
    struct Card: Identifiable {
        var isChoosed: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: Int
        
        let symbol: Symbols
        let texture: Texture
        let color: Color
        let quantityOfSymbols: Int
    }
}

enum Symbols {
    case diamond
    case squiggle
    case ellipse
}

enum Texture {
    case strokedSymbol
    case filledSymbol
    case shadedSymbol
}

enum Color {
    case red
    case green
    case purple
}

extension Array {
    var twoMatched {
        
    }
}
