//
//  HabitDetailView.swift
//  iHabit
//
//  Created by Anvar Rahimov on 10.07.2022.
//

import SwiftUI

struct HabitDetailView: View {
    
    @Binding var habit: HabitItem
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(habit.description)
                
                Stepper("Counter: \(habit.counter)", value: $habit.counter, in: 0...999999)
                
                Spacer()
            }
            .padding()
            .navigationTitle(habit.name)
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: .constant(HabitItem(name: "Programming", description: "I want to be a software developer", counter: 0)))
    }
}
