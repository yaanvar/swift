//
//  SetGame.swift
//  Set
//
//  Created by Anvar Rahimov on 17.08.2021.
//

import Foundation

protocol Matchable {
    static func match(cards: [Self]) -> Bool
}

struct SetGame<CardContent> where CardContent: Matchable {
    private(set) var cards = [Card]()
    private(set) var deck = [Card]()
    
    let numberOfCardToMatch = 3
    var numberOfCardsToStart = 12
    
    init(numberOfCardsToStart: Int, numberOfCardsInDeck: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        deck = [Card]()
        self.numberOfCardsToStart = numberOfCardsToStart
        for index in 0..<numberOfCardsInDeck {
            let content = cardContentFactory(index)
            deck.append(Card(content: content, id: index))
        }
        deck.shuffle()
    }
    
    mutating func deal(_ numberOfCards: Int? = nil) {
        let number = numberOfCards ?? numberOfCardsToStart
        for _ in 0..<number {
            cards.append(deck.remove(at: 0))
        }
    }
    
    private var selectedIndices: [Int] { cards.indices.filter { cards[$0].isSelected } }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: card),
           !cards[chosenIndex].isSelected,
           !cards[chosenIndex].isMatched {
            // selected = 2
            if selectedIndices.count == 2 {
                cards[chosenIndex].isSelected = true
                if CardContent.match(cards: selectedIndices.map { cards[$0].content }) {
                    // matched
                    for index in selectedIndices {
                        cards[index].isMatched = true
                    }
                } else {
                    // not matched
                    for index in selectedIndices {
                        cards[index].isNotMatched = true
                    }
                }
            } else {
                // selected < 2 || selected > 2
                if selectedIndices.count == 1 || selectedIndices.count == 0 {
                    cards[chosenIndex].isSelected = true
                } else {
                    changeCards()
                    onlySelectedCards(chosenIndex)
                }
            }
        }
    }
    
    private mutating func onlySelectedCards(_ onlyIndex: Int) {
        for index in cards.indices {
            cards[index].isSelected = index == onlyIndex
            cards[index].isNotMatched = false
        }
    }
    
    private var matchedIndices: [Int] { cards.indices.filter { cards[$0].isSelected && cards[$0].isMatched } }
    
    private mutating func changeCards() {
        guard matchedIndices.count == numberOfCardToMatch else { return }
        let replaceIndices = matchedIndices
        if deck.count >= numberOfCardToMatch && cards.count == numberOfCardsToStart {
            // replace matched cards
            for index in replaceIndices {
                cards.remove(at: index)
                cards.insert(deck.remove(at: 0), at: index)
            }
        } else {
            //remove matched cards
            cards = cards.enumerated()
                .filter{ !replaceIndices.contains($0.offset) }
                .map { $0.element }
        }
    }
    
    struct Card: Identifiable {
        var isSelected: Bool = false
        var isMatched: Bool = false
        var isNotMatched: Bool = false
        var content: CardContent
        var id: Int
    }

}
