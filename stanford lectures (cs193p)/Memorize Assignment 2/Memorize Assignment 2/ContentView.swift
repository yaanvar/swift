//
//  ContentView.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.themeName)
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.newGame()
                } label: {
                    Text("New Game")
                }
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
            }
            .padding(15)
            .font(.title)
            .foregroundColor(Color.blue)
            
        }
        .foregroundColor(viewModel.themeColor)
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













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
