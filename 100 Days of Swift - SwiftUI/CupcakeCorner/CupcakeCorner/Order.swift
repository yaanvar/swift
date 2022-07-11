//
//  Order.swift
//  CupcakeCorner
//
//  Created by Anvar Rahimov on 11.07.2022.
//

import SwiftUI

class Order: ObservableObject {
    @Published var item = OrderItem()
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var cost: Double {
        // $2 per cake
        var cost = Double(item.quantity) * 2

        // complicated cakes cost more
        cost += (Double(item.type) / 2)

        // $1/cake for extra frosting
        if item.extraFrosting {
            cost += Double(item.quantity)
        }

        // $0.50/cake for sprinkles
        if item.addSprinkles {
            cost += Double(item.quantity) / 2
        }

        return cost
    }
    
    var hasValidAddress: Bool {
        if item.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || item.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || item.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || item.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }

}
