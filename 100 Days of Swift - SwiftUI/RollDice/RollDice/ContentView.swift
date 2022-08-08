//
//  ContentView.swift
//  RollDice
//
//  Created by Anvar Rahimov on 08.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sides = 4
    @State private var amountOfDices = 1
    @State private var results = [Int]()
    
    var body: some View {
        VStack {
            if !results.isEmpty {
                List {
                    ForEach(0..<results.count, id: \.self) { diceNumber in
                        Text("Dice №\(diceNumber + 1): \(results[diceNumber])")
                    }
                }
            }
            
            Spacer()
            
   
            VStack {
                Text("Total result: \(results.reduce(0, +))")
                Stepper("Sides: \(sides)", value: $sides, in: 4...100)
                Stepper("Amount of dices: \(amountOfDices)", value: $amountOfDices, in: 1...10)
            }
            .padding()
            
            Button("Roll", action: rollTheDice)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        
    }
    
    func rollTheDice() {
        results = [Int]()
        
        for _ in 0..<amountOfDices {
            results.append(Int.random(in: 1...sides))
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
