//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anvar Rahimov on 07.08.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
