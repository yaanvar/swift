//
//  ContentView.swift
//  iExpense
//
//  Created by Anvar Rahimov on 06.07.2022.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        VStack {
            Text("Hello, \(name)!")
        
            Button("Dismiss") {
                dismiss()
            }
        }
        .padding()
    }
}

struct User: Codable {
    var firstName: String = "Vyacheslav"
    var lastName: String = "Ushakov"
}

struct ContentView: View {

    @State private var user = User()
    
    @State private var isShowingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName )")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Show sheet") {
                isShowingSheet.toggle()
            }
            
            Button("Save user") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user) {
                    UserDefaults.standard.set(data, forKey: "user ")
                }
                
                
            }
            
            .sheet(isPresented: $isShowingSheet) {
                SecondView(name: "slava")
            }
            
            List {
                ForEach(numbers, id: \.self) {
                    Text("Row \($0)")
                }
                .onDelete { offsets in
                    numbers.remove(atOffsets: offsets)
                }
            }
            
            Button("Add Number") {
                numbers.append(currentNumber)
                currentNumber += 1
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
