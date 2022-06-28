//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Anvar Rahimov on 28.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) { student in
                        Text(student)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
