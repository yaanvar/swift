//
//  AstronautView.swift
//  Moonshot
//
//  Created by Anvar Rahimov on 09.07.2022.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    let divider: some View = Rectangle()
        .frame(height: 2)
        .foregroundStyle(.lightBackground)
        .padding(.vertical)
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                divider
                
                Text(astronaut.description)
                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astranouts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astranouts["armstrong"]!)
    }
}
