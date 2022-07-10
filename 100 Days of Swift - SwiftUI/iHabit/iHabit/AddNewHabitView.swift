//
//  AddNewHabitView.swift
//  iHabit
//
//  Created by Anvar Rahimov on 10.07.2022.
//

import SwiftUI

struct AddNewHabitView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var habits: Habits
    
    @State private var name = ""
    @State private var description = ""
    @State private var counter = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit", text: $name)
                
                TextField("Description", text: $description)
                
                Stepper("Counter: \(counter)", value: $counter, in: 0...999999)
            }
            .navigationTitle("New Habit")
            .toolbar {
                Button("Save") {
                    let item = HabitItem(name: name, description: description, counter: counter)
                    habits.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabitView(habits: Habits())
    }
}
