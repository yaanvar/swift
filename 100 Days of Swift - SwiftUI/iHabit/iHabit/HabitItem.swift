//
//  HabitItem.swift
//  iHabit
//
//  Created by Anvar Rahimov on 10.07.2022.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var counter: Int
}
