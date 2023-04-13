//
//  TabBar.swift
//  TabBar
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(selectedTab: $selectedTab,
                         image: "house")
            TabBarButton(selectedTab: $selectedTab,
                         image: "house")
            TabBarButton(selectedTab: $selectedTab,
                         image: "house")
            TabBarButton(selectedTab: $selectedTab,
                         image: "house")
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView
    }
}

struct TabBarButton: View {
    @Binding selectedTab: String
    var image: String
    
    var body: some View {
        GeometryReader { reader in in
            Button(action: {}, label: {
                Image(systemName: image)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(Color("TabSelected"))
            })
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            
        }
    }
}
