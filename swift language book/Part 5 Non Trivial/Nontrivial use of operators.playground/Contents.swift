import UIKit

struct Vector2D {
    var x = 0.0, y = 0.0
}

//+

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let vector = Vector2D(x: 3.0, y: 2.0)
let anotherVector = Vector2D(x: 5.0, y: 2.0)
let combineVector = vector + anotherVector

//prefix

prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 2.0, y: 2.0)
let negative = -positive

//custom

func += (left: inout Vector2D, right: Vector2D) {
    left = left + right
}
var original = Vector2D(x: 0.0, y: 0.0)
let vectorToAdd = Vector2D(x: 1.0, y: 1.0)
original += vectorToAdd

//equalence

func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("these two vectors aren't equal")
}

//operators

prefix operator +++
prefix func +++ (vector: inout Vector2D) -> Vector2D {
    vector += vector
    return vector
}
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
