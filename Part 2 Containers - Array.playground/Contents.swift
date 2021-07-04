import UIKit

let alphaberArray = ["a", "b", "c"]
var mutableArray = [2, 4, 6, 8]

let newArray = Array(arrayLiteral: 1, 2, 3, 4, 5)
print(newArray)

//sequence array
let lineArray = Array(0...10)
print(lineArray)

//repeat array
let repeatArray = Array(repeating: "Swift", count: 5)
print(repeatArray)

//changing array
var stringArray = ["one", "two", "three", "four"]
stringArray[1...2] = ["five"]
print(stringArray)

//type of array
let arrayOne: Array<Character> = ["a", "b", "c"]
let arrayTwo: [Int] = [1, 2, 3, 4, 5]

//empty arrays
let emptyArray: [String] = []
let anotherEmptyArray = [String]()

//array merge
let charsOne = ["a", "b", "c"]
let charsTwo = ["d", "e", "f"]
let charsThree = ["g", "h", "i"]
var alphabet = charsOne + charsTwo
alphabet += charsThree
print(alphabet)

//matrix
var matrix = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
print(matrix)
print(matrix[0][1])

//function count
let someArray = [1, 2, 3, 4, 5]
print(someArray.count)

//function isEmpty
print(emptyArray.isEmpty)

//slice
var numArray = [1, 2, 3, 4, 5]
let sliceOfArray = numArray[numArray.count-3...numArray.count-1]
print(sliceOfArray)

//suffix
let subArray = numArray.suffix(3)
print(subArray)

//first and last
numArray.first
numArray.last

//append
numArray.append(6)
print(numArray)

//insert
numArray.insert(7, at: 6)
print(numArray)

//remove first, last, remove(at:)
numArray.remove(at: 4)
numArray.removeLast()
numArray.removeFirst()
print(numArray)

//droplast or dropfirst
let newNumArray = numArray.dropLast()
let newNewNumArray = newNumArray.dropFirst()
print(newNewNumArray)

//contains
print(newNewNumArray.contains(4))
print(newNewNumArray.contains(19))

var randomArray = [2, 5, 6, 2, 10, 53, -10]
//min max
randomArray.min()
randomArray.max()

//reverse
randomArray.reverse()

//sort and sorted
randomArray = randomArray.sorted()
randomArray.sort()

//randomElement
randomArray.randomElement()

//array slice
let arrayOfNumbers = Array(1...10)
let slice = arrayOfNumbers[4...6]
let arrayFromSlice = Array(slice)
print(slice[5])
