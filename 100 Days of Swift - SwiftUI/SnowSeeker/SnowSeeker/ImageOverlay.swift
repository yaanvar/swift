//
//  ImageOverlay.swift
//  SnowSeeker
//
//  Created by Anvar Rahimov on 09.08.2022.
//

import SwiftUI

struct ImageOverlay: View {
    
    let resort: Resort
    
    var body: some View {
        ZStack {
            Text("Credit: \(resort.imageCredit)")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }
        .background(Color.gray)
        .opacity(0.7)
        .cornerRadius(10.0)
        .padding(6)
    }
}
struct ImageOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ImageOverlay(resort: Resort.example)
    }
}
