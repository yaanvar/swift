import UIKit

let possibleString = "1945"
let convertPossibleString = Int(possibleString)

let unpossibleString = "one thousand fourty five"
let convertUnpossibleString = Int(unpossibleString)

type(of: convertPossibleString)
type(of: convertUnpossibleString)

//double to int and string to int comparison

let double = 43.2
let convertDouble = Int(double)
type(of: convertDouble)

let string = "43"
let convertString = Int(string)
type(of: convertString)

//optionals

let optionalChar: Optional<Character> = "a"
type(of: optionalChar)

var optionalInt: Int? = 14
type(of: optionalInt)

optionalInt = nil

let optionalBool: Bool?

var optionalValue = Optional("some text")
optionalValue = nil
optionalValue

//optionals in tuples

var tuple: (Int, String)? = nil
tuple = (404, "Page not found")

var anotherTuple: (Int?, Int) = (nil, 15)
anotherTuple
type(of: anotherTuple)

//extraction of optional values

//force unwrapping

var optionalVar: Int? = 12
var anotherVar = 15
var result = anotherVar + optionalVar!
type(of: optionalVar!)

let optString: String? = "Anvar Rahimov"
let unwrapperString = optString!
print( "My name is \(unwrapperString)" )

//implicitly unwrapping

var wrapDouble: Double! = 12.2
type(of: wrapDouble)
var result2 = 15.2 + wrapDouble

//checking for values in optionals before unwrapping

let optOne: UInt? = nil
let optTwo: UInt? = 32
optOne != nil
optTwo != nil

var excellentMark: Int? = 5
var cakesForMarks = 0
if excellentMark != nil {
    cakesForMarks = 2 * excellentMark!
}
cakesForMarks

//optional binding

var pointX: Double? = 15.2
var pointY: Double? = -25.6
if let x = pointX, let y = pointY {
    print("Your position is (\(x); \(y))")
} else {
    print("You are not even on a map getta hell out of here dont waste my time")
}

let coinsNewChest = "123"
var allCoins = 1432
if let coins = Int(coinsNewChest) {
    allCoins += coins
} else {
    print("there are no cash there are not even chest")
}
allCoins

//nil coalescing

let unwrappedInt: Int? = 15
var mustHaveValue = unwrappedInt ?? 0
unwrappedInt

var mustHaveValue2 = 0
if let unwrapped = unwrappedInt {
    mustHaveValue2 = unwrapped
} else {
    mustHaveValue2 = 0
}
