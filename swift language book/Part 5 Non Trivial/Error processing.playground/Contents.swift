import UIKit

enum FileError: Error {
    case notExist
    case notRights
}

//

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
    
}
var accountBalans = 0
var productPrice = 0
guard productPrice <= accountBalans else {
    let diff = productPrice - accountBalans
    throw VendingMachineError.insufficientFunds(coinsNeeded: diff)
}

//proccessing errors

enum CustomError: Error {
    case wrongName
}

func funcThrowsError() throws {
    throw CustomError.wrongName
}

func funcGetsError() throws -> String {
    try funcThrowsError()
    return "text result"
}

//funcGetsError()

//

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = ["Candy Bar": Item(price: 12, count: 7), "Chips": Item(price: 10, count: 4), "Pretzels": Item(price: 7, count: 11)]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("dispensing \(snack)")
    }
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price < coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(snack: name)
    }
}

let favoriteSnacks = ["Alice": "Chips", "Bob": "Licorice", "Eve": "Pretzels",]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("invalid selection")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("need more coins")
} catch VendingMachineError.outOfStock {
    print("out of stock")
}

//optional

func someThrowingFunction() throws -> Int {
    return 1
}
let x = try? someThrowingFunction()

//structs and classes as errirs

struct NetworkError: Error {
    var code: Int
    func description() -> String {
        return "it's network error with code \(code)"
    }
}

do {
    throw NetworkError(code: 404)
} catch let error as NetworkError {
    print(error.description())
}
