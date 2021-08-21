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
    
    //MARK: init
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isSelected,
           !cards[chosenIndex].isMatched
        {
            switch alreadySelected {
            case 0...1:
                cards[chosenIndex].isSelected = true
            case 2:
                cards[chosenIndex].isSelected = true
                if isItMatch {
                    let tempAlreadySelectedIndices = alreadySelectedIndices
                    cards.remove(at: tempAlreadySelectedIndices[0])
                    cards.remove(at: tempAlreadySelectedIndices[1])
                    cards.remove(at: tempAlreadySelectedIndices[2])
                }
            default:
                print("some bug in choose, dude")
            }
        }
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           cards[chosenIndex].isSelected {
            cards[chosenIndex].isSelected = false
        }
    }
    
    var isItMatch: Bool {
        var cardsForChecking = alreadySelectedCards(indices: alreadySelectedIndices)
        if cardsForChecking[0].symbol == cardsForChecking[1].symbol
            && cardsForChecking[1].symbol == cardsForChecking[2].symbol
            && cardsForChecking[0].symbol == cardsForChecking[2].symbol {
            cardsForChecking[0].isMatched = true
            cardsForChecking[1].isMatched = true
            cardsForChecking[2].isMatched = true
            return true
        }
        if cardsForChecking[0].texture == cardsForChecking[1].texture
            && cardsForChecking[1].texture == cardsForChecking[2].texture
            && cardsForChecking[0].texture == cardsForChecking[2].texture {
            cardsForChecking[0].isMatched = true
            cardsForChecking[1].isMatched = true
            cardsForChecking[2].isMatched = true
            return true
        }
        if cardsForChecking[0].color == cardsForChecking[1].color
            && cardsForChecking[1].color == cardsForChecking[2].color
            && cardsForChecking[0].color == cardsForChecking[2].color {
            cardsForChecking[0].isMatched = true
            cardsForChecking[1].isMatched = true
            cardsForChecking[2].isMatched = true
            return true
        }
        if cardsForChecking[0].quantityOfSymbols == cardsForChecking[1].quantityOfSymbols
            && cardsForChecking[1].quantityOfSymbols == cardsForChecking[2].quantityOfSymbols
            && cardsForChecking[0].quantityOfSymbols == cardsForChecking[2].quantityOfSymbols {
            cardsForChecking[0].isMatched = true
            cardsForChecking[1].isMatched = true
            cardsForChecking[2].isMatched = true
            return true
        }
        return false
    }
    
    var alreadySelected: Int {
        var counter = 0
        for item in cards {
            if item.isSelected {
                counter += 1
            }
        }
        return counter
    }
    
    var alreadySelectedIndices: [Int] {
        var tempAlreadySelectedIndices = [Int]()
        for index in cards.indices {
            if cards[index].isSelected {
                tempAlreadySelectedIndices.append(index)
            }
        }
        return tempAlreadySelectedIndices
    }
    
    func alreadySelectedCards(indices: [Int]) -> [Card] {
        var tempAlreadySelectedCards = [Card]()
        for index in indices {
            tempAlreadySelectedCards.append(cards[index])
        }
        return tempAlreadySelectedCards
    }
    
    
    struct Card: Identifiable {
        var isSelected: Bool = false
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
