import UIKit
import Foundation

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
