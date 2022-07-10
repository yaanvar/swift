//
//  ContentView.swift
//  iHabit
//
//  Created by Anvar Rahimov on 10.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var habits = Habits()
    
    var body: some View {
        HabitListView(habits: habits)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
