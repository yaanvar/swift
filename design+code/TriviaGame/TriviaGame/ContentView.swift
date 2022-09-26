//
//  ContentView.swift
//  TriviaGame
//
//  Created by Anvar Rahimov on 27.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40){
            VStack(spacing: 20) {
                Text("Trivia Game")
                    .lilacTitle()
                    
                Text("Are you ready to test out your trivia skills?")
                    .foregroundColor(Color("AccentColor"))
            }
            
            PrimaryButton(text: "Let's go!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color("BackgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
