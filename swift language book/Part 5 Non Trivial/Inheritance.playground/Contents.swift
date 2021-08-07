import UIKit

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
dog.printName()

//override

final class NoisyDog: Dog {
    override func bark() {
        for _ in 1...3 {
            super.bark()
        }
    }
}

var noisyDog = NoisyDog()
noisyDog.bark()

//

var animalsArray: [Quadruped] = []
var someAnimal = Quadruped()
var myDog = Dog()
var sadDog = NoisyDog()
animalsArray.append(someAnimal)
animalsArray.append(myDog)
animalsArray.append(sadDog)

for item in animalsArray {
    print(type(of: item))
}

//

for item in animalsArray {
    if item is Dog {
        print("yeap")
    }
}

//

for item in animalsArray {
    if let animal = item as? NoisyDog {
        animal.bark()
    } else if let animal = item as? Dog {
        animal.bark()
    } else {
        item.walk()
    }
}
