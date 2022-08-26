//
//  ContentView.swift
//  BiometricsAuth
//
//  Created by Anvar Rahimov on 26.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LoginView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
