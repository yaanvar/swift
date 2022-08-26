//
//  Title.swift
//  BiometricsAuth
//
//  Created by Anvar Rahimov on 26.08.2022.
//

import SwiftUI

struct Title: View {
    var body: some View {
        Text("Authenticator")
            .bold()
            .font(.title)
            .foregroundColor(.white)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
            .background(LinearGradient(colors: [.blue, .purple],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
    }
}
