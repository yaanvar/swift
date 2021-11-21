//
//  Timer.swift
//  SimplePomodoro
//
//  Created by Anvar Rahimov on 21.11.2021.
//

import SwiftUI

struct Timer {
    var workInterval: UInt = 25
    var shortBreakInterval: UInt = 5
    var longBreakInterval: UInt = 30
    var rounds: UInt = 4
    var isWorking: Bool = false
}
