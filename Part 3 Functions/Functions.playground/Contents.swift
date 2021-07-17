import UIKit

func greetings() {
    let greeting = "Hello, playground"
    print(greeting)
}
greetings()

func greetings2() -> () {
    let greeting = "Hello, playground"
    print(greeting)
}
greetings2()

func greetings3() -> Void {
    let greeting = "Hello, playground"
    print(greeting)
}
greetings3()

func sumTwoInt(a: Int, b: Int) {
    print(a + b)
}
sumTwoInt(a: 14, b: 14)

func sumTwoDouble(num1 a: Double, num2 b: Double) {
    print(a + b)
}
sumTwoDouble(num1: 2.42, num2: 234.1)

func sumTwoInt2(_ a: Int, _ b: Int) {
    print(a + b)
}
sumTwoInt2(15, 25)

func sumTwoDouble2(num1 a: Double, num2 b: Double) -> Double {
    return a + b
}
let resultDouble = sumTwoDouble2(num1: 51, num2: 132.2)
print(resultDouble)

//inout

func changeValues(_ a: inout Int, _ b: inout Int) -> Void {
    let tmp = a
    a = b
    b = tmp
}
var x = 150, y = 45
changeValues(&x, &y)
x
y

//arrayLiteral

func printNumbers(numbers: Int...) {
    print(numbers)
}
printNumbers(numbers: 1, 3, 2, 4, 6)

//tuples

func getCodeDescription(code: Int) -> (Int, String) {
    let description: String
    switch code {
    case 1...100:
        description = "Error"
    case 101...200:
        description = "Correct"
    default:
        description = "Unknown"
    }
    return (code, description)
}

func getCodeDescription2(code: Int) -> (code: Int, description: String) {
    let description: String
    switch code {
    case 1...100:
        description = "Error"
    case 101...200:
        description = "Correct"
    default:
        description = "Unknown"
    }
    return (code, description)
}
let request = getCodeDescription2(code: 25)
request.description
request.code

//

func returnMessage(code: Int, message: String = "code - ") -> String {
    var mutableMessage = message
    mutableMessage += String(code)
    return mutableMessage
}
returnMessage(code: 300)

func returnMessage2(code: Int, message: String = "code - ") -> String {
    message + String(code)
}
returnMessage2(code: 300)

//

func printText() {
    print("some totally normal text")
}

func returnPrintText() -> () -> Void {
    return printText
}

let newFunction = returnPrintText()
newFunction()

//functions in functions

func generateWallet(walletLength: Int) -> [Int] {
    let typesOfBanknots = [50, 100, 200, 500, 1000, 2000, 5000]
    var wallet: [Int] = []
    for _ in 1...walletLength {
        wallet.append(typesOfBanknots.randomElement()!)
    }
    return wallet
}

func sumWallet(bancnotesFunction wallet: (Int) -> [Int], walletLength: Int) -> Int? {
    let myWalletArray = wallet(walletLength)
    var sum: Int = 0
    for banknote in myWalletArray {
        sum += banknote
    }
    return sum
}

sumWallet(bancnotesFunction: generateWallet, walletLength: 14)

//lazy calculating

func oneStep(coordinates: inout (Int, Int), stepType: String) {
    func up(coordinates: inout (Int, Int)) {
        coordinates = (coordinates.0, coordinates.1 + 1)
    }
    func down(coordinates: inout (Int, Int)) {
        coordinates = (coordinates.0, coordinates.1 - 1)
    }
    func right(coordinates: inout (Int, Int)) {
        coordinates = (coordinates.0 + 1, coordinates.1)
    }
    func left(coordinates: inout (Int, Int)) {
        coordinates = (coordinates.0 - 1, coordinates.1)
    }
    
    switch stepType {
    case "up":
        up(coordinates: &coordinates)
    case "down":
        down(coordinates: &coordinates)
    case "right":
        right(coordinates: &coordinates)
    case "left":
        left(coordinates: &coordinates)
    default:
        break
    }
}

var coordinates = (10, 5)
oneStep(coordinates: &coordinates, stepType: "up")
oneStep(coordinates: &coordinates, stepType: "right")
coordinates

//overload

func say(what: String) -> Void {}
func say(what: Int) -> Void {}

func cry() -> String {
    return "one"
}
func cry() -> Int {
    return 1
}

//let someFunc = cry()
let someFunc: String = cry()

//recursion

func fibonacci(number: Int) -> Int {
    if number == 0 {
        return 0
    } else if number == 1 {
        return 1
    } else if number == 2 {
        return 1
    }
    return fibonacci(number: number - 1) + fibonacci(number: number - 2)
}
fibonacci(number: 5)
