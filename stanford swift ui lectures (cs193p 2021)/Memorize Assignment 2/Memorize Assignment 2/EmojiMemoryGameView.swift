//
//  EmojiMemoryGameView.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(game.getThemeName)
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            
            Spacer()
            
            HStack {              
                Button {
                    game.newGame()
                } label: {
                    Text("New Game")
                }
                
                Spacer()
                
                Text("Score: \(game.score)")
            }
            .padding(15)
            .font(.title)
            .foregroundColor(Color.blue)
            
        }
        //.foregroundColor(game.getThemeColor)
        .foregroundColor(.blue)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}








struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let themeStore = ThemeStore(named: "Preview")
        
        let game = EmojiMemoryGame(theme: themeStore.theme(at: 0))
        EmojiMemoryGameView(game: game)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
