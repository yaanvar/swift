//
//  ContentView.swift
//  Memorize
//
//  Created by Anvar Rahimov on 07.08.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 3)
                    
            Text("Hello, world!")
        }
        .padding(.horizontal)
        .foregroundColor(.red)
        
    }
}



















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
