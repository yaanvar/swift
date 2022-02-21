//
//  SetGameViewModel.swift
//  Set
//
//  Created by Anvar Rahimov on 19.08.2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    @Published private var model: SetGame<SetCard> = SetGameViewModel.createSetGame()
    
    static func createSetGame()-> SetGame<SetCard> {
        SetGame<SetCard> (numberOfCardsStart: numberOfCardsStart,
                    numberOfCardsInDeck: deck.cards.count) { index in
            deck.cards[index]
        }
    }
    static var numberOfCardsStart = 12
    static private var deck = SetCardDeck()
    
    //MARK: - Access to the model
    
    var cards: Array<SetGame<SetCard>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: Array<SetGame<SetCard>.Card>) {
        model.choose(card: card)
    }
    
    func deal() {
        model.deal()
    }

}
