//
//  ContentView.swift
//  iExpense
//
//  Created by Anvar Rahimov on 06.07.2022.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    func colorForExpense(_ item: ExpenseItem) -> Color {
        switch item.amount {
        case 0...10:
            return .primary
        case 10...100:
            return .blue
        case 100...:
            return .red
        default:
            return .yellow
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Personal expenses") {
                        ForEach(expenses.items, id: \.id) { item in
                            if item.type == "Personal" {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                            .font(.subheadline)
                                    }

                                    Spacer()
                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                        .foregroundColor(colorForExpense(item))
                                }
//                                .accessibilityElement()
//                                .accessibilityLabel(item.name)
//                                .accessibilityHint(item.type)
                            }
                        }
                        .onDelete { offsets in
                            expenses.items.remove(atOffsets: offsets)
                        }
                    }
                }
                
                List {
                    Section("Business expenses") {
                        ForEach(expenses.items, id: \.id) { item in
                            if item.type == "Business" {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                            .font(.subheadline)
                                    }

                                    Spacer()
                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                        .foregroundColor(colorForExpense(item))
                                }
//                                .accessibilityElement()
//                                .accessibilityLabel(item.name)
//                                .accessibilityHint(item.type)
                            }
                        }
                        .onDelete { offsets in
                            expenses.items.remove(atOffsets: offsets)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
