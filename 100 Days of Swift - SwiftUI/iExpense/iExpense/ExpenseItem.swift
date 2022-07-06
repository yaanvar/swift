//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Anvar Rahimov on 06.07.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
