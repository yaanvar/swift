//
//  EmojiMemoryGame.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
   
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            let arrayEmojis = Array(theme.emojis)
            return String(arrayEmojis[pairIndex])
        }
    }
   
    @Published private var model: MemoryGame<String>
    
    var theme: Theme
    
    var getThemeName: String {
        get {
            return theme.name
        }
    }
    
    var score: Int {
        return model.score
    }
    
    var getThemeColor: Color {
        get {
            return Color(rgbaColor: theme.themeColor)
        }
    }
   
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
   
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
