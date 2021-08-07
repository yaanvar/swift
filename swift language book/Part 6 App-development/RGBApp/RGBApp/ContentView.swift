//
//  ContentView.swift
//  RGBApp
//
//  Created by Anvar Rahimov on 06.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var redComponent = 0.5
    @State var greenComponent = 0.5
    @State var blueComponent = 0.5
    
    var body: some View {
        VStack(content: {
            Slider(value: $redComponent)
            Slider(value: $greenComponent)
            Slider(value: $blueComponent)
            Color(red: redComponent, green: greenComponent, blue: blueComponent)
        })
        .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
