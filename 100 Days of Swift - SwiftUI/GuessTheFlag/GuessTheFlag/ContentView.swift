//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anvar Rahimov on 30.06.2022.
//

import SwiftUI

struct FlagImage: View {
    var number: Int
    var countries: [String]
    
    var body: some View {
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var round = 1
    @State private var animationAmount = 0.0
    @State private var animateOpacity = 1.0
    @State private var chosenFlag = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            chosenFlag = number
                            withAnimation(.spring()) {
                                animationAmount += 360
                                animateOpacity = 0.25
                            }
                        } label: {
                            FlagImage(number: number, countries: countries)
                        }
                        .rotation3DEffect(.degrees(number == chosenFlag ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number != chosenFlag ? animateOpacity : 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score) points")
            }
            .alert("Game Over", isPresented: $showingGameOver) {
                Button("Restart", action: newGame)
            } message: {
                Text("Your score is \(score) points")
            }
            .shadow(radius: 5)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! It's flag of \(countries[number])"
        }
        
        round += 1
        
        if round > 8 {
            showingGameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        withAnimation {
            self.animationAmount -= 360
            self.animateOpacity = 1
        }
    }
    
    func newGame() {
        askQuestion()
        round = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
