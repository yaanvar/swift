//
//  Move.swift
//  Project34
//
//  Created by Anvar Rahimov on 04.03.2022.
//

import UIKit

import GameplayKit
import UIKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int

    init(column: Int) {
        self.column = column
    }
}
