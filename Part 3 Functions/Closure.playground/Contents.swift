import UIKit

let functionInLet = { return true }
functionInLet()

//using closures

var wallet = [10, 50, 100, 100, 5000, 100, 50, 50, 500, 100]

func handle(wallet: [Int], closure: (Int) -> Bool) -> [Int] {
    var returnWallet = [Int]()
    for banknote in wallet {
        if closure(banknote) {
            returnWallet.append(banknote)
        }
    }
    return returnWallet
}

func compare100(banknote: Int) -> Bool{
    return banknote == 100
}
func compareMore1000(banknote: Int) -> Bool {
    return banknote >= 1000
}

let resultWalletOne = handle(wallet: wallet, closure: compare100(banknote:))
let resultWalletTwo = handle(wallet: wallet, closure: compareMore1000(banknote:))

let resultWalletThree = handle(wallet: wallet, closure: { (banknote: Int) -> Bool in return banknote >= 1000 })
resultWalletThree

//

let resultWalletFour = handle(wallet: wallet, closure: { banknote in return banknote == 100 })
resultWalletFour

//

let resultWalletFive = handle(wallet: wallet, closure: { banknote in banknote == 100 })
resultWalletFive

//

let resultWalletSix = handle(wallet: wallet, closure: { $0 == 100 })
resultWalletSix

//

let resultWalletSeven = handle(wallet: wallet){ $0 == 100 }
resultWalletSeven

//

func networkQuery(url: String, success: (String) -> Bool, error: (Int) -> ()) {
    //
}

networkQuery(url: "https://weather.com", success: { data in 1 == 0 }, error: { errorCode in })

//unnamed type

let closure: () -> Void = { print("Closure type") }

let closurePrint: (String) -> Void = { text in print(text) }
closurePrint("Hey!!")

var sum: (_ numOne: Int, _ numTwo: Int) -> Int = { return $0 + $1 }
sum(10, 35)

//sorting with closures

let array = [1,44,81,4,277,50,101,51,8]
var sortedArray = array.sorted(by: { (first: Int, second: Int) -> Bool in return first < second })
sortedArray
sortedArray = array.sorted(by: { $0 > $1 })
sortedArray
sortedArray = array.sorted(by: <)

//conquest of vars in closures

var a = 3
var b = 4
var closureSum: () -> Int = {
    a + b
}
closureSum()
a = 5
b = 6
closureSum()

//

var c = 3
var d = 5
var closureSum2: () -> Int = { [c, d] in
    c + d
}
closureSum2()
c = 5
d = 15
closureSum2()

//

func makeIncrement(forIncrement amount: Int) -> () -> (Int) {
    var runningTotal = 0
    func increment() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return increment
}

var incrementByTen = makeIncrement(forIncrement: 10)
var incrementBySeven = makeIncrement(forIncrement: 7)
incrementByTen()
incrementByTen()
incrementByTen()
incrementBySeven()
incrementBySeven()
incrementBySeven()

//closures are linked

var incrementByFive = makeIncrement(forIncrement: 5)
var copyIncrementByFive = incrementByFive
incrementByFive()
copyIncrementByFive()
incrementByFive()

//autoclosures

var arrayOfNames = ["Helga", "Arnold", "Alex"]
func printName(name: String) {
    print(name)
}
printName(name: arrayOfNames.remove(at: 0))
arrayOfNames

func printName2(name: () -> String) {
    print(name())
}
printName2(name: { arrayOfNames.remove(at: 0) })
arrayOfNames

func printName3(name: @autoclosure () -> String) {
    print(name())
}
printName3(name: arrayOfNames.remove(at: 0))

//escaping slosure

var arrayOfClosures: [() -> Int] = []
func addNewClosure(_ newClosure: @escaping () -> Int) {
    arrayOfClosures.append(newClosure)
}
addNewClosure({return 100})
addNewClosure({return 200})
arrayOfClosures[0]()
arrayOfClosures[1]()
