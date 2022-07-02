//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anvar Rahimov on 02.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var items = ["Rock": "🪨", "Paper": "📄", "Scissors": "✂️" ].shuffled()
    @State private var chosenItemNumber = Int.random(in: 0...2)
    @State private var isWin = Bool.random()
    @State private var score = 0
    @State private var isShowingScore = false
    @State private var round = 1
    
    func returnItemButton(image: String, title: String) -> some View {
        Button {
            switch items[chosenItemNumber].key {
            case "Rock":
                if title == "Paper" && isWin {
                    score += 1
                } else if title == "Scissors" && !isWin {
                    score += 1
                } else {
                    score -= 1
                }
            case "Paper":
                if title == "Scissors" && isWin {
                    score += 1
                } else if title == "Rock" && !isWin {
                    score += 1
                } else {
                    score -= 1
                }
            case "Scissors":
                if title == "Rock" && isWin {
                    score += 1
                } else if title == "Paper" && !isWin {
                    score += 1
                } else {
                    score -= 1
                }
            default:
                break
            }
            
            round += 1
            
            if round > 9 {
                isShowingScore = true
            }
            
            chosenItemNumber = Int.random(in: 0...2)
            isWin = Bool.random()
        } label: {
            VStack {
                Text(image)
                    .font(Font.system(size: 30))
                Text(title)
            }
            .foregroundStyle(.white)
        }
        .animation(.easeInOut(duration: 1))
    }

    func restartTheGame() {
        chosenItemNumber = Int.random(in: 0...2)
        isWin = Bool.random()
        score = 0
        isShowingScore = false
        round = 0
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mint, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                Spacer()
                
                Text("Tap to \(isWin ? "win" : "lose")")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text(items[chosenItemNumber].value)
                    .font(Font.system(size: 120))
                Text(items[chosenItemNumber].key)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Spacer()
                    returnItemButton(image: "🪨", title: "Rock")
                    Spacer()
                    returnItemButton(image: "📄", title: "Paper")
                    Spacer()
                    returnItemButton(image: "✂️", title: "Scissors")
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .padding([.trailing], 40)
                }
            }
        }
        .alert("Game Over", isPresented: $isShowingScore) {
            Button("Play again", action: restartTheGame)
        } message: {
            Text("Your score: \(score)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
