//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anvar Rahimov on 30.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    
    var body: some View {
        Button("Show Alert") {
            showAlert = true
        }
        .alert("Important message", isPresented: $showAlert) {
            Button("OK", role: .none) {
                
            }
            Button("Cancel", role: .cancel) {
                
            }
            Button("Delete", role: .destructive) {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
