//
//  SetCard.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import Foundation

struct SetCard {
    let shape: Version
    let fill: Version
    let color: Version
    let number: Version
    
    enum Version: Int, CaseIterable {
        case v1 = 1
        case v2 = 2
        case v3 = 3
    }
}
