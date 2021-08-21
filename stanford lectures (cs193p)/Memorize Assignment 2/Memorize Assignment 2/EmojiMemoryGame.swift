//
//  EmojiMemoryGame.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
   
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
   
    @Published private var model: MemoryGame<String>
        
    private var theme: Theme
    
    var themeName: String {
        return theme.name
    }
    
    var score: Int {
        return model.score
    }
    
    var themeColor: Color {
        switch theme.themeColor {
        case "red":
            return .red
        case "green":
            return .green
        case "purple":
            return .purple
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "blue":
            return .blue
        default:
            return .red
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
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // MARK: - Theme(s)
    
    static var themes: Array<Theme> = [
        Theme(name: "Halloween",
              emojis: ["💀", "👻", "🎃", "🧟‍♀️", "👺", "👹", "🎭"],
              numberOfPairsOfCards: 5,
              themeColor: "orange"
        ),
        Theme(name: "Flags",
              emojis: ["🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🏁", "🏴", "🚩", "🎌", "🇯🇵"],
              numberOfPairsOfCards: 6,
              themeColor: "blue"
        ),
        Theme(name: "Smiles",
              emojis: ["😀", "🤩", "🥳", "😎", "😜", "😘", "😇", "🥺", "😂", "😆", "😅"],
              numberOfPairsOfCards: 7,
              themeColor: "yellow"
        ),
        Theme(name: "Food",
              emojis: ["🍋", "🫒", "🍓", "🍑", "🥝", "🍅", "🍆", "🥑", "🥥", "🍒", "🍇", "🍉", "🍌", "🍏"],
              numberOfPairsOfCards: 8,
              themeColor: "green"
        ),
        Theme(name: "Tech",
              emojis: ["🎥", "📼", "📟", "📻", "📺", "📷", "💾", "🕹", "🖨", "🖱", "⌨️", "🖥", "💻", "📱", "⌚️"],
              numberOfPairsOfCards: 10,
              themeColor: "purple"
        ),
        Theme(name: "Vehicles",
              emojis: ["✈️", "🚂", "🛸", "🚀", "🚗", "🚑", "🚒", "🚜", "🚲", "🛴", "🏍", "🚄", "🚁", "🚤", "🚡", "🚟", "🚌", "🚚", "🛶", "🛺", "🛵", "🛻", "🦽", "🚃"],
              numberOfPairsOfCards: 9,
              themeColor: "red"
        )
    ]
}
