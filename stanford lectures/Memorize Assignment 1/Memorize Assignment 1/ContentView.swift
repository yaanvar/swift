//
//  ContentView.swift
//  Memorize Assignment 1
//
//  Created by Anvar Rahimov on 15.08.2021.
//

import SwiftUI

var vehicleEmojis = ["✈️", "🚂", "🛸", "🚀", "🚗", "🚑", "🚒", "🚜", "🚲", "🛴", "🏍", "🚄", "🚁", "🚤", "🚡", "🚟", "🚌", "🚚", "🛶", "🛺", "🛵", "🛻", "🦽", "🚃"]
var smileEmojis = ["😀", "🤩", "🥳", "😎", "😜", "😘", "😇", "🥺", "😂", "😆", "😅"]
var flagEmojis = ["🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🏁", "🏴", "🚩", "🎌", "🇯🇵"]

struct ContentView: View {
    @State var emojis = vehicleEmojis
    @State var emojiCount = 20
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehicle
                Spacer()
                smile
                Spacer()
                flag
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    var vehicle: some View {
        Button {
            emojis = vehicleEmojis.shuffled()
            //emojiCount = Int.random(in: 4..<vehicleEmojis.count)
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.caption)
            }
            .padding()
        }
    }
    var smile: some View {
        Button {
            emojis = smileEmojis.shuffled()
            emojiCount = Int.random(in: 4..<smileEmojis.count)
        } label: {
            VStack {
                Image(systemName: "face.smiling")
                Text("Smiles")
                    .font(.caption)
            }
            .padding()
        }
    }
    var flag: some View {
        Button {
            emojis = flagEmojis.shuffled()
            emojiCount = Int.random(in: 4..<flagEmojis.count)
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags")
                    .font(.caption)
            }
            .padding()
        }
    }
}





struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill().foregroundColor(.red)
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
        ContentView().preferredColorScheme(.dark)
    }
}

