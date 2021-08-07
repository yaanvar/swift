import UIKit

let myRange = 1..<10
print(myRange)

let someRangeInt: Range<Int> = 1..<10
type(of: someRangeInt)

let rangeString = "a"..<"z"

let rangeChar: Range<Character> = "a"..<"z"

let rangeDouble = 1.0..<5.0

let firstElement = 10
var secondeElement = 18
let myBestRange = firstElement..<secondeElement

//one side range
let oneSideRange = ..<5
type(of: oneSideRange)

//closed range
let myClosedRange = 1...5
print(myClosedRange)
type(of: myClosedRange)

//one side postfix range
let oneSideRange2 = 5...
type(of: oneSideRange2)

//example of use ranges in collection
let collection = [1, 5, 10, 15, 20, 25, 30]
let infRange = 2...
print(collection[infRange])

//one side prefix range
let oneSideRange3 = ...5
type(of: oneSideRange3)

//function count
let template = 1...10
print(template.count)

//function contains
let templateFloat = 1.0...2.0
print(templateFloat.contains(1.69))

//function isEmpty
let emptyRange = 0..<0
print(emptyRange.isEmpty)

//function min and max
let minMaxRange = 1..<5
minMaxRange.min()
minMaxRange.max()

//function upperBound and lowerBound
let template2 = 1..<5
template2.lowerBound
template2.upperBound

let rangeOne = ...10
let rangeTwo = ..<10
