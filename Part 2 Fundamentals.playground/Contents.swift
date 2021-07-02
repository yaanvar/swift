import UIKit
import Foundation

let someText = "I'm studying Swift!"
var someText2: String = "I'm studying Swift again!"

let age: Int
age = 16

var variableOne = 15.0
var variableTwo: Int = Int(variableOne)

var someNumberString: String = "15"
var someNumber = Int(someNumberString)

var Num: Int = -15
var UNum: UInt = 15
var Num64: Int64 = 99999999999999
var Num32: Int32 = 9999999

let minInt8 = Int8.min
let minInt16 = Int16.min
let minInt32 = Int32.min
let minInt64 = Int64.min

let minUInt8 = UInt8.min
let maxUInt8 = UInt8.max

let numFloat: Float = 104.3
let numDouble: Double = 104.4342423523523

var number = 5
number += 5
number *= number

var numberDouble = 5.0
numberDouble += 3
numberDouble *= 6
numberDouble /= 3

let firstFloat: Float = 3.14
let secondFloat: Float = 1.01
let result: Float = firstFloat.truncatingRemainder(dividingBy: secondFloat)

var numberEven = 6
var even: Bool = numberEven.isMultiple(of: 2)

let decimalInt = 17
let binaryInt = 0b10001
let octalInt = 0o21
let hexadecimalInt = 0x11

let exponentNum = 1.25e2
let hexExponentNum = 0xFp-2

let bigNumber = 1000000
let bigNumberCopy = 1_000_000

var myWallet = Double(0)
var incomeAfterOperation = Double(0.1)

myWallet += incomeAfterOperation
print(myWallet)
myWallet += incomeAfterOperation
print(myWallet)
myWallet += incomeAfterOperation
print(myWallet)
myWallet += incomeAfterOperation
print(myWallet)

var myWalletDecimal = Decimal(0)
var incomeAfterOperationDecimal = Decimal(0.1)

myWalletDecimal += incomeAfterOperationDecimal
print(myWalletDecimal)
myWalletDecimal += incomeAfterOperationDecimal
print(myWalletDecimal)
myWalletDecimal += incomeAfterOperationDecimal
print(myWalletDecimal)
myWalletDecimal += incomeAfterOperationDecimal
print(myWalletDecimal)

let char: Character = "a"
let stingOne: String = "Hello!"
var emptyString: String = ""
var anotherEmptyString = String()

let longString = """
    Really long String
    Really loooooooong
    """
print(longString)

var notEmptyString = String("Hello, Juniour Swift Developer!")
var someDoubleNum = 74.22
var someStringNum = String(someDoubleNum)

var name = "Dragon"
var hello = "Hey, my name is \(name)"
var meters = 10.0
let text = "My length is \(meters * 3.28) foots"
print(hello)
print(text)

let firstText = "My weight is "
let weight = 12.4
let secondText = " tons"
let resultText = firstText + String(weight) + secondText
print(resultText)

let myCharOverUnicode = Character("\u{041A}")

let isDragon = true
let isKnight = false

if isDragon {
    print("Hello, Dragon!")
} else {
    print("Hello, Troll!")
}

typealias AgeType = UInt8
var myAge = AgeType(16)
var maxAge = AgeType.max

let myVar = 3.54
print(type(of: myVar))

//task 1
var kilometers = 2
var seconds = 120
var speed = kilometers * 1000 / (seconds / 60)
print(speed)

//task 2
var nums1 = 111
var nums2 = 222
var nums3 = Int("\(nums1)\(nums2)")

//task 3
var myInt8 = Int8.min
var myUInt8 = UInt8.max

//task 4
var firstNum = 6
var secondNum = Int(6)
var bufferNum = firstNum
firstNum = secondNum
secondNum = bufferNum

//task 5
let constFloat = Float(5)
var variousDouble = 19.42
variousDouble = 42.42
