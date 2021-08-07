//
//  main.swift
//  unknown number
//
//  Created by Anvar Rahimov on 17.07.2021.
//

import Foundation

var unknownNumber = UInt8.random(in: 1...250)
print("Unknown number was riddled by Computer. Try to guess it.")
var isWin = false
repeat {
    guard let userNumber = UInt8(readLine() ?? "") else {
        print("You entered inappropriate symbol. Please try again.")
        continue
    }
    if userNumber > unknownNumber {
        print("Your number is bigger than Computer's...")
    } else if userNumber < unknownNumber {
        print("Your number less than Computer's...")
    } else {
        print("You guessed!!!")
        isWin = true
    }
} while !isWin
