//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Anvar Rahimov on 09.08.2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .previewInterfaceOrientation(.portrait)
    }
}
