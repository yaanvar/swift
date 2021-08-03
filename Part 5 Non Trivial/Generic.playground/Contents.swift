import UIKit

var firstInt = 1
var secondInt = 2

func changeInt(first: inout Int, second: inout Int) {
    let temp = first
    first = second
    second = temp
}

changeInt(first: &firstInt, second: &secondInt)

var firstString = "smth"
var secondString = "smthsmth"

func changeString(first: inout String, second: inout String) {
    let temp = first
    first = second
    second = temp
}

changeString(first: &firstString, second: &secondString)

//generic

func change<T>(first: inout T, second: inout T) {
    let temp = first
    first = second
    second = temp
}

change(first: &firstString, second: &secondString)
firstString
secondString
change(first: &firstInt, second: &secondInt)
firstInt
secondInt

//

func printValues<T1,T2>(a: T1, b: T2) {
    print("value 1 - \(a), value 2 - \(b)")
}

printValues(a: "bool", b: 0)
printValues(a: 0, b: 1)

//

func getSelf<T>(_ a: T) -> T {
    return a
}
getSelf(15)

//numeric

func sum<T: Numeric>(_ a: T, _ b: T) -> T {
    return a + b
}

sum(5, 5)
sum(5.0, 5.0)

func sumDifferent<T>(_ a: T, _ b: T) -> T where T: Numeric {
    return a + b
}

//comparable

func search<T: Comparable>(value: T, in collection: [T]) -> Bool {
    for item in collection {
        if item == value {
            return true
        }
    }
    return false
}
var array = [1, 2, 3, 4, 5]
search(value: 2, in: array)

//universal object type

struct Stack1<T: Numeric> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.insert(contentsOf: [item], at: 0)
    }
    mutating func pop() -> T {
        return items.removeFirst()
    }
}

//universal protocols

func search<T1, T2>(value: T1, in collection: T2) -> Bool where T1: Comparable, T2: Collection, T1 == T2.Element {
    for item in collection {
        if item == value {
            return true
        }
    }
    return false
}

//stack

protocol StackProtocol {
    associatedtype ItemType
    var items: [ItemType] { get set }
    mutating func push(_: ItemType)
    mutating func pop() -> ItemType
}

extension StackProtocol {
    mutating func push(_ item: ItemType) {
        items.insert(contentsOf: [item], at: 0)
    }
    mutating func pop() -> ItemType {
        return items.removeFirst()
    }
}

struct Stack<T>: StackProtocol {
    typealias ItemType = T
    var items: [T] = []
}

//opaque type

protocol Vehicle {
    associatedtype Identifier
    var uid: Identifier { get set }
    init()
}

struct Car: Vehicle {
    var uid: Int = 0
}

struct Truck: Vehicle {
    var uid: String = ""
}

func getObject<T: Vehicle>() -> T {
    return T()
}

let someVehicle: Car = getObject()
let anotherVehicle: Truck = getObject()

func getCar() -> some Vehicle {
    return Car(uid: 92)
}

let someCar = getCar()
