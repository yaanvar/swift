import UIKit

let mySet: Set<Int> = [1, 5, 0]

let mySet2: Set = [2, 3, 4]

let mySet3 = Set<Int>(arrayLiteral: 2, 4, 3)

let mySet4 = Set(arrayLiteral: 4, 3, 2, 5, 5, 5)

//empty set
let emptySet = Set<String>()

var setWithValues: Set<String> = ["bread", "vegetables"]
//deleting
setWithValues = []

//function insert
var musicStyleSet: Set = ["Jazz", "Hip-Hop", "Rock"]
musicStyleSet.insert("Indie")

//removing
var removeStyleResult = musicStyleSet.remove("Hip-Hop")
removeStyleResult
musicStyleSet
musicStyleSet.removeAll()

var mySetOfNames = Set(arrayLiteral: "Gosha", "Slava", "Anvar", "Vova", "Dima", "Yura")
//contains
mySetOfNames.contains("Me")
mySetOfNames.contains("Vova")

//count
mySetOfNames.count

//operations
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 5, 6, 8]
let differentDigits: Set = [3, 4, 7, 8]

let intersection = differentDigits.intersection(oddDigits)
let symmetricDifference = differentDigits.symmetricDifference(evenDigits)
let union = evenDigits.union(oddDigits)
let subtracting = oddDigits.subtracting(differentDigits)

//subsets
let aSet: Set = [1, 2, 3, 4, 5]
let bSet: Set = [1, 3]
let cSet: Set = [5, 6, 7, 8]

let copyOfBSet = bSet
bSet == copyOfBSet

bSet.isSubset(of: aSet)

bSet.isDisjoint(with: cSet)

bSet.isStrictSubset(of: aSet)

aSet.isStrictSuperset(of: bSet)

//sorted
var setOfNums: Set = [42, 53, 2, 5, 6, -1]
var sortedArray = setOfNums.sorted()
type(of: sortedArray)
