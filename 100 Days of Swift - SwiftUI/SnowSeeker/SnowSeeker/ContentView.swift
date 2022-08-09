//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Anvar Rahimov on 09.08.2022.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct User: Identifiable {
    let id = "Taylor Swift"
}

struct ContentView: View {
    @State private var layoutVertically = false
    
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var searchText = ""
    
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
        NavigationView {
            List(filteredNames, id:\.self) { name in
                Text(name)
            }
            .searchable(text: $searchText)
            .navigationTitle("Searching")
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
