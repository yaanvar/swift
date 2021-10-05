//
//  ThemeManager.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 09.09.2021.
//

import SwiftUI

struct ThemeManager: View {
    @ObservedObject var store: ThemeStore
    @State private var viewID: Int = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    let gameView = EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))
                        .id(viewID)
                        .onDisappear {
                            viewID += 1
                        }
                    NavigationLink(destination: gameView) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                            Text(theme.emojis)
                        }
                    }
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }

            }
            .navigationTitle("Themes")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ThemeManager(store: ThemeStore(named: "Preview"))
    }
}
