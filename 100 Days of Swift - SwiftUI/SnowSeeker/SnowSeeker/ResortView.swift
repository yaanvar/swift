//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Anvar Rahimov on 09.08.2022.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(44)
                    .padding()
                
                HStack {
                    ResortDetailsView(resort: resort)
                    SkiDetailsView(resort: resort)
                }
                .padding()
                .background(Color.primary.opacity(0.1))
                .cornerRadius(44)
                .padding()

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    Text(resort.facilities, format: .list(type: .and))
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
