//
//  OrderItem.swift
//  CupcakeCorner
//
//  Created by Anvar Rahimov on 11.07.2022.
//

import Foundation

struct OrderItem: Codable {
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}
