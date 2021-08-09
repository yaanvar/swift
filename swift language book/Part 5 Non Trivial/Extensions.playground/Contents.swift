import UIKit
import Foundation

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

