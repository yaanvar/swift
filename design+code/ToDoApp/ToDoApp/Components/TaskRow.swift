//
//  TaskRow.swift
//  ToDoApp
//
//  Created by Anvar Rahimov on 21.08.2022.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: completed ? "checkmark.circle" : "circle")
            
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "do laundry", completed: true)
    }
}
