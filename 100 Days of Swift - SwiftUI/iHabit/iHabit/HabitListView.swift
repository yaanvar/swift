//
//  HabitListView.swift
//  iHabit
//
//  Created by Anvar Rahimov on 10.07.2022.
//

import SwiftUI

struct HabitListView: View {
    
    @ObservedObject var habits: Habits
    
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach($habits.items, id: \.id) { $item in
                    HStack {
                        NavigationLink {
                            HabitDetailView(habit: $item)
                        } label: {
                            Text(item.name)
                            
                            Spacer()
                            
                            Text("\(item.counter)")
                        }
                    }
                }
                .onDelete { offsets in
                    habits.items.remove(atOffsets: offsets)
                }
            }
            .navigationTitle("iHabit")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddNewHabitView(habits: habits)
            }
        }
    }
}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitListView(habits: Habits())
    }
}
