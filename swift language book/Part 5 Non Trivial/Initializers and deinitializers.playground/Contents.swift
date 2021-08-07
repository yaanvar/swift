import UIKit

//classes

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
    convenience init(text: String) {
        self.init()
        print(text)
    }
}

final class NoisyDog: Dog {
    override func bark() {
        for _ in 1...3 {
            super.bark()
        }
    }
}

//convinience init()

var someDog = Dog(text: "is it shiba-inu?")

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

var object = SubClass(isNil: false)
object = nil
