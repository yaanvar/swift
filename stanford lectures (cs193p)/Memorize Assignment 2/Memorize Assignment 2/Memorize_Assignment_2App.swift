//
//  Memorize_Assignment_2App.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

@main
struct Memorize_Assignment_2App: App {
    var body: some Scene {
        let game = EmojiMemoryGame()
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
