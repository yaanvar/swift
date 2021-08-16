//
//  EmojiMemoryGame.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static var emojis = ["✈️", "🚂", "🛸", "🚀", "🚗", "🚑", "🚒", "🚜", "🚲", "🛴", "🏍", "🚄", "🚁", "🚤", "🚡", "🚟", "🚌", "🚚", "🛶", "🛺", "🛵", "🛻", "🦽", "🚃"]
    static var theme: Theme { get { self.theme } }
   
    static func createMemoryGame(chosenTheme theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
   
    @Published private var model: MemoryGame<String> = createMemoryGame(chosenTheme: theme)
   
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
   
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
