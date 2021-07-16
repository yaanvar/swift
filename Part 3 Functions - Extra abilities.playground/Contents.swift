import UIKit

//map

let myArray = [2, 3, 4, 6]
let newArray = myArray.map{$0*$0}
newArray

let intArray = [2, 3, 4, 5]
let boolArray = intArray.map{$0 > 2}
boolArray

let numbers = [1, 2, 3, 4, 5]
let mapped = numbers.map{ Array(repeating: $0, count: $0)}
mapped

let milesToDest = ["Moscow": 120.0, "Dubai": 50.0, "Paris": 70.0]
let kmToDest = milesToDest.map{name, miles in [name:miles * 1.6093]}
kmToDest

//mapValues

let mappedCloseStars = ["Proxima Centauri": 4.24, "Alpha Centauri A": 4.37]
let newCollection = mappedCloseStars.mapValues{ $0 + 1 }
newCollection

//flatMap

let numbers2 = [1, 2, 3, 4, 5]
let mapped2 = numbers2.flatMap{ Array(repeating: $0, count: $0)}
mapped2

//compactMap

let stringArray = ["1", "2", "3", "four", "5"]
let intFromStringArray = stringArray.map() { Int($0) }
intFromStringArray

let intFromStringArray2 = stringArray.compactMap() { Int($0) }
intFromStringArray2

//filter

let numArray = [1, 4, 10, 15]
let even = numArray.filter() { $0 % 2 == 0 }
even

let starDistanceDict = ["Wolf 359": 7.78, "Alpha Centauri B": 4.37, "Barnard's Star": 5.96]
let closeStars = starDistanceDict.filter() { $0.value < 5 }
closeStars

//reduce

let cash = [10, 50, 100, 500]
let money = cash.reduce(0, +)
let multiTotal = cash.reduce(1, { $0 * $1 })
multiTotal

//zip

let collectionOne = [1, 2, 3]
let collectionTwo = [4, 5, 6]

let sequenceToZip = zip(collectionOne, collectionTwo)
sequenceToZip
let array = Array(sequenceToZip)
let dictionary = Dictionary(uniqueKeysWithValues: sequenceToZip)
dictionary

//guard for optionals

func countSideOfShape(shape: String) -> Int? {
    switch shape {
    case "triangle":
        return 3
    case "rectangle":
        return 4
    case "square":
        return 4
    default:
        return nil
    }
}

func printCountSides(shape: String) {
    if let sides = countSideOfShape(shape: shape) {
        print("figure \(shape) has \(sides) sides")
    } else {
        print("unknown amount of sides of \(shape) figure")
    }
}

func printCountSides2(shape: String) {
    guard let sides = countSideOfShape(shape: shape) else {
        print("unknown amount of sides of \(shape) figure")
        return
    }
    print("figure \(shape) has \(sides) sides")
}

//defer

func someFunction() {
    defer {
        print("action in defer")
    }
    defer {
        print("another action in defer")
    }
    print("action in function")
}
someFunction()
