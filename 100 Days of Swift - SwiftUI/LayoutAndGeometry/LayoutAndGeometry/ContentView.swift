//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Anvar Rahimov on 08.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        CGFloat(position) * -10
                    }
            }
       }
       .background(.red)
       .frame(width: 400, height: 400)
       .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
