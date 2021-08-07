import UIKit

var things = [Any]()
things.append(0)
things.append(0.0)
things.append((0, 0))
things.append("0")
things.append({ (name: String) -> String in "Hello, \(name)" })

//type cast Any

for thing in things {
    switch thing {
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double:
        print("a double value of \(someDouble)")
    case let (x, y) as (Int, Int):
        print("an (x, y) point at \(x), \(y)")
    case let someString as String:
        print("a string value of \(someString)")
    case let greatingsFunction as (String) -> String:
        print(greatingsFunction("Shiba-Inu"))
    default:
        print("something else")
    }
}

//AnyObject

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

final class NoisyDog: Dog {
    override func bark() {
        for _ in 1...3 {
            super.bark()
        }
    }
}

let someObjects: [AnyObject] = [Dog(), NoisyDog()]

//type cast AnyObject

for object in someObjects {
    let animal = object as! Dog
    print(animal.type)
}

for object in someObjects as! [Dog] {
    print(object.type)
}

//with guard

for object in someObjects {
    guard let animal = object as? Dog else {
        continue
    }
    print(animal.type)
}

for object in (someObjects as? [Dog]) ?? [] {
    print(object.type)
}
