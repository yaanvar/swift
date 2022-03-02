//
//  ContentView.swift
//  WatchLandmarks Extension
//
//  Created by Anvar Rahimov on 29.08.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
