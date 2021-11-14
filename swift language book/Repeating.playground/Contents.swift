import UIKit

//MARK: - Autoclosures

var arrayOfNames = ["Helga", "Bazil", "Alex"]
func printName(nextName: @autoclosure ()->String) {
    print(nextName())
}
//printName(nextName: arrayOfNames.remove(at: 0))

//MARK: - Escaping closures

var arrayOfClosures: [()->Int] = []
func addNewClosureInArray(_ newClosure: @escaping ()->Int) {
    arrayOfClosures.append(newClosure)
}
addNewClosureInArray({return 100})
addNewClosureInArray{return 1000}
arrayOfClosures[0]()
arrayOfClosures[1]()

//MARK: - Static


struct AudioChannel {
    static var maxVolume = 5
    var volume: Int {
        didSet {
            if volume > AudioChannel.maxVolume {
                volume = AudioChannel.maxVolume
            }
} }
}
var LeftChannel = AudioChannel(volume: 2)
var RightChannel = AudioChannel(volume: 3)
RightChannel.volume = 6
RightChannel.volume // 5
AudioChannel.maxVolume // 5
AudioChannel.maxVolume = 10
AudioChannel.maxVolume // 10
RightChannel.volume = 8
RightChannel.volume // 8

//MARK: - Subscripts

class ChessMan {
    
    let type: ChessManType
    let color: ChessManColor
    var coordinates: (String, Int)? = nil
    let figureSymbol: Character
    init(type: ChessManType, color: ChessManColor, figureSymbol: Character) {
        self.type = type
        self.color = color
        self.figureSymbol = figureSymbol
    }
    init(type: ChessManType, color: ChessManColor, figureSymbol: Character, coordinates: (String, Int)) {
        self.type = type
        self.color = color
        self.figureSymbol = figureSymbol
        setCoordinates(char: coordinates.0, num: coordinates.1)
    }
    enum ChessManType {
        case king, queen, castle, knight, bishop, pawn
    }
    enum ChessManColor {
        case black, white
    }
    func setCoordinates(char: String, num: Int) {
        coordinates = (char, num)
    }
    func kill() {
        coordinates = nil
    }
    
}

class GameDesk {
    var desk: [Int:[String:ChessMan]] = [:]
    init() {
        for i in 1...8 {
            desk[i] = [:]
        }
    }
    func setChessMan(chess: ChessMan, coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."H"
        if rowRange.contains(coordinates.1) && colRange.contains(coordinates.0) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            //print("coordinates out of range")
        }
    }
    subscript(alpha: String, number: Int) -> ChessMan? {
        get {
            return self.desk[number]![alpha]
        } set {
            if let chessman = newValue {
                self.setChessMan(chess: chessman, coordinates: (alpha, number))
            } else {
                self.desk[number]![alpha] = nil
            }
        }
    }
}

var gameDesk = GameDesk()
var queenBlack = ChessMan(type: .queen, color: .black, figureSymbol: "\u{265B}", coordinates: ("A", 6))
gameDesk.setChessMan(chess: queenBlack, coordinates: ("A", 3))
gameDesk["A", 3]?.coordinates
gameDesk["C", 5] = queenBlack
gameDesk["C", 5] = nil
gameDesk["C", 5]?.coordinates

//MARK: - Inheritance

class Quadruped {
    var type = ""
    var name = ""
    func walk() {
        print("walk")
    }
    init() {}
}

class Dog: Quadruped {
    func bark() {
        print("woof")
    }
    func printName() {
        print(self.name)
    }
    override init() {
        super.init()
        self.type = "dog"
    }
}

var dog = Dog()
dog.type = "dog"
dog.walk()
dog.bark()

dog.name = "Kagyr Maur Diffin Aep-Keallah"
//dog.printName()

//override

final class NoisyDog: Dog {
    override func bark() {
        for _ in 1...3 {
            super.bark()
        }
    }
}

var noisyDog = NoisyDog()
//noisyDog.bark()

//

var animalsArray: [Quadruped] = []
var someAnimal = Quadruped()
var myDog = Dog()
var sadDog = NoisyDog()
animalsArray.append(someAnimal)
animalsArray.append(myDog)
animalsArray.append(sadDog)

for item in animalsArray {
    //print(type(of: item))
}

//

for item in animalsArray {
    if item is Dog {
        //print("yeap")
    }
}

//

for item in animalsArray {
    if let animal = item as? NoisyDog {
        animal.bark()
    } else if let animal = item as? Dog {
        animal.bark()
    } else {
        //item.walk()
    }
}

//MARK: - Any


var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append("hello")
things.append((3.0, 5.0))
things.append({ (name: String) -> String in "Hello, \(name)" })

/*for thing in things {
    switch thing {
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Troll"))
default:
        print("something else")
    }
}*/

// AnyObject

let someObjects: [AnyObject] = [Dog(), NoisyDog(), Dog()]

for object in someObjects {
    let animal = object as! Dog
    print(animal.type)
}

//MARK: - Initializers

//failable initializer

class Rectangle {
    var height: Int
    var width: Int
    init? (height h: Int, width w: Int) {
        self.height = h
        self.width = w
        if !(h > 0 && w > 0) {
            return nil
        }
    }
}

var rectangle = Rectangle(height: 56, width: -32)

enum TemperatureUnit {
    case Celcius, Fahrenheit, Kelvin
    init? (symbol: Character) {
        switch symbol {
        case "C":
            self = .Celcius
        case "F":
            self = .Fahrenheit
        case "K":
            self = .Kelvin
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")

//required initializer

//required init(parameters) {
//
//}

//deinitializer

class SuperClass {
    init? (isNil: Bool) {
        if isNil == true {
            return nil
        } else {
            print("instance created")
        }
    }
    deinit {
        print("deinitializing superclass")
    }
}

class SubClass: SuperClass {
    deinit {
        print("deinitializing subclass")
    }
}

//var object = SubClass(isNil: false)
//object = nil

//MARK: - Control of memory

class Application {
    var name: String
    
    init(name: String) {
        print("creating instance")
        self.name = name
    }
    
    deinit {
        print("destroying instance")
    }
}

func loadResources(forApp: Application) {
    print("start of the function loadResources")
    let _ = "./bin/\(forApp.name)/"
    //
    print("end of the function loadResources")
}

func main(testMode: Bool) {
    print("start of the function main")
    let app = Application(name: "Calculator")
    loadResources(forApp: app)
    //
    print("end of the function main")
}

main(testMode: true)

//deinit instances

print()

class House {
    var title: String
    var owner: Human?
    
    init(title: String, owner: Human? = nil) {
        print("House of \(title) created")
        self.owner = owner
        self.title = title
        return
    }
    
    deinit {
        print("House of \(title) destroyed")
    }
}

class Human {
    var name: String
    
    init(name: String) {
        print("Owner \(name) created")
        self.name = name
        return
    }
    
    deinit {
        print("Owner \(name) destroyed")
    }
}

if true {
    let houseOwner = Human(name: "Anvar")
    if true {
        let _ = House(title: "House", owner: houseOwner)
    }
    let _ = House(title: "Flat", owner: houseOwner)
}

//memory leak and ARC

print()

//strong, weak and unowned references

//references in closures

var a = 2
let f = { return a }
f()
a = 3
f()

class Man {
    var name: String = "Human"
    deinit {
        print("Human deleted")
    }
}
var closure: (() -> Void)?

if true {
    let man = Man()
    closure = { [unowned man] in
      print(man.name)
    }
    closure!()
}
print("Program has ended")

//MARK: - Protocols

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get }
}

struct SomeStruct: SomeProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    func getSum() -> Int {
        return self.mustBeSettable + self.doesNotNeedToBeSettable
    }
}

struct AnotherStruct: SomeProtocol, AnotherProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    static var someTypeProperty: Int = 3
    func getSum() -> Int {
        return self.mustBeSettable + self.doesNotNeedToBeSettable + AnotherStruct.someTypeProperty
    }
}

//metods

protocol RandomNumberGenerator {
    var randomCollection:  [Int] { get set }
    func getRandomNumber() -> Int
    mutating func setNewRandomCollection(newValue: [Int])
}

struct RandomGenerator: RandomNumberGenerator {
    var randomCollection: [Int] = [1, 2, 3, 4, 5]
    
    func getRandomNumber() -> Int {
        if let randomElement = randomCollection.randomElement() {
            return randomElement
        }
        return 0
    }
    
    mutating func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

class RandomGeneratorClass: RandomNumberGenerator {
    var randomCollection: [Int] = [1, 2, 3, 4, 5]
    
    func getRandomNumber() -> Int {
        if let randomElement = randomCollection.randomElement() {
            return randomElement
        }
        return 0
    }
    
    func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

//init

protocol Named {
    init(name: String)
}

class Person: Name {
    var name: String
    required init(name: String) {
        self.name = name
    }
}

//as! and as?

protocol HashValue {
    var value: Int { get set }
}

class ClassWithValue: HashValue {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

struct StructWithValue: HashValue {
    var value: Int
}

let objects: [Any] = [2, StructWithValue(value: 3), true, ClassWithValue(value: 6), "Swift"]

for object in objects {
    if let elementWithValue = object as? HashValue {
        print("Value of \(elementWithValue)")
    }
}

//is

for object in objects {
    print(object is HashValue)
}

//inheritance of protocols

protocol GeometricFigureWithXAxis {
    var x: Int { get set }
}

protocol GeometricFigureWithYAxis {
    var y: Int { get set }
}

protocol GeometricFigureWithTwoAxis: GeometricFigureWithXAxis, GeometricFigureWithYAxis {
    var distanceFromCenter: Float { get }
}

struct Figure2D: GeometricFigureWithTwoAxis {
    var x: Int = 0
    var y: Int = 0
    var distanceFromCenter: Float {
        let xPow = pow(Double(self.x), 2)
        let yPow = pow(Double(self.y), 2)
        let length = sqrt(xPow + yPow)
        return Float(length)
    }
}

//only class portocol

protocol SuperProtocol { }
protocol SubProtocol: AnyObject, SuperProtocol { }
class  ClassWithProtocol: SubProtocol { }

//protocol composition

protocol Named_ {
    var name: String { get }
}

protocol Aged_ {
    var age: Int { get }
}

struct Person_: Named_, Aged_ {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: Named_ & Aged_) {
    print("Happy \(celebrator.age)th birthday, \(celebrator.name)!")
}

let birthdayPerson = Person_(name: "John Wick", age: 46)
wishHappyBirthday(celebrator: birthdayPerson)

//MARK: - Extension

extension Double {
    var asKM: Double { return self / 1000 }
    var asM: Double { return self }
    var asCM: Double { return self * 100 }
    var asMM: Double { return self * 100 * 10 }
    var asFT: Double {
        get {
            return self / 0.3048
        } set {
            self = newValue * 0.3048
        }
    }
}

var length = 25.0
length.asKM
length.asMM

length.asFT
length.asFT = 5

//metods in extensions

extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
    
    mutating func squared() {
        self = self * self
    }
}

3.repetitions {
    print("Swift")
}

var someInt = 5
someInt.squared()

//intializers in extensions

struct Line {
    var pointOne: (Double, Double)
    var pointTwo: (Double, Double)
}

extension Double {
    init(line: Line) {
        self = sqrt(pow((line.pointTwo.0 - line.pointOne.0), 2) + pow((line.pointTwo.1 - line.pointOne.1), 2))
    }
}

var myLine = Line(pointOne: (10, 10), pointTwo: (14, 10))
var lengthOfTheLine = Double(line: myLine)

//subscripts in extensions

extension Int {
    subscript( digitIndex: Int ) -> Int {
        var base = 1
        var index = digitIndex
        while index > 0 {
            base *= 10
            index -= 1
        }
        return (self / base) % 10
    }
}
746381295[0]
746381295[1]

//extensions of protocols

protocol TextRepresentable {
    func asText() -> String
}

extension Int: TextRepresentable {
    func asText() -> String {
        return String(self)
    }
    func about() -> String {
            return "this type supports protocol TextRepresentable"
        }
}

5.asText()
5.about()


//extensinon of protocols

protocol Descriptional {
    func getDescription() -> String
}

extension Descriptional {
    func getDescription() -> String {
        return "object type reference"
    }
}

class MyClass: Descriptional {}
print(MyClass().getDescription())


