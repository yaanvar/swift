import UIKit

let constTuple = (5, 3, 2)
print(constTuple)

var variousTuple = (16, "Anvar", true)
print(type(of: variousTuple))

let (firstNumber, secondNumber, thirdNumber) = constTuple
print(constTuple)
print(firstNumber)

let anotherConstTuple: (time: Int, place: String, work: String) = (12, "Moscow", "Developer")
print(anotherConstTuple.place)
let anotherAnotherConstTuple = (money: 16, percentage: 0.24)
print(anotherAnotherConstTuple.percentage)


