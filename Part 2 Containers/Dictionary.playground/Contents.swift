import UIKit

let dictionary = ["one": 1, "two": 2, "three": 3]
dictionary

let secondDictionary = Dictionary(dictionaryLiteral: (1, "one"), (2, "two"), (3, "three"))
secondDictionary

//tuples array into dictionary

let baseCollection = [(2, 3), (3, 6), (5, 3)]
let newDictionary = Dictionary(uniqueKeysWithValues: baseCollection)
newDictionary

//two arrayz into dictionary with zip function

let nearestStarNames = ["Proxima Centauri", "Alpha Centauri A", "Alpha Centauri B"]
let nearestStarDistances = [4.24, 4.37, 4.37]
let starDistancesDictionary = Dictionary(uniqueKeysWithValues: zip(nearestStarNames, nearestStarDistances))
starDistancesDictionary

//explicit declaration

let dictOne: Dictionary<Int, Bool> = [100: false, 200: true, 300: true]
let dictTwo: [String:String] = ["Anvar": "Green", "Gosha": "Red", "Slava": "Blue"]

//value change

var countryDict = ["RUS": "Россия", "UKR": "Украина", "BEL": "Беларусь"]
var countryName = countryDict["BEL"]
countryDict["RUS"] = "Российская Федерация"
countryDict

var oldValueOne = countryDict.updateValue("Республика Беларусь", forKey: "BEL")
var oldValueTwo = countryDict.updateValue("Эстония", forKey: "EST")

countryDict["TUR"] = "Турция"
countryDict

//deleting

countryDict.removeValue(forKey: "TUR")
countryDict

//empty dictionary

let emptyDictionary: [String:Int] = [:]
let anotherEmptyDictionary = Dictionary<String,Int>()

//deleting all dictionary

var birthYears = [1991: ["John", "Ann", "Vasiliy"], 1993: ["Alex", "Boris"] ]
birthYears = [:]

//function count

var someDictionary = [1: "A", 2: "B", 3: "C"]
someDictionary.count

//function isEmpty

emptyDictionary.isEmpty
someDictionary.isEmpty

//keys and values

let keys = someDictionary.keys
keys
let values = someDictionary.values
values

//values and keys in arrays

type(of: keys)
let keysArray = Array(keys)
type(of: keysArray)
