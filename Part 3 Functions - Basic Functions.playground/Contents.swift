import UIKit

//assert

var dragonAge = 230
assert(dragonAge <= 235, "dragon is too old")
assert(dragonAge >= 225, "dragon is too young")
assert(dragonAge != 0)
print("program complete")

//if statement

if dragonAge > 235 {
    print("dragon is too old")
} else if dragonAge < 225 {
    print("dragon is too young")
} else {
    print("he seems middle-age for a dragon")
}

dragonAge > 235 ?  print("dragon is too old"): print("at least this dragon not old")

var a = 100
var b = 70
if a > 50 && b > 50 {
    print("a and b > 50")
}
if a > 50, b > 50 {
    print("a and b > 50")
}
if let a1 = Int("43"), let b1 = Int("45"), a1 < b1 {
    print("a1 < b1")
}

//switch-case

let userMark = 4
var message = ""
switch userMark {
case 1,2:
    message = "exam is failed"
case 3:
    message = "not bad but not good too"
case 4:
    message = "seems nice"
case 5:
    message = "u nailed it"
default:
    message = "some inappropriate information here"
}
print(message)

switch userMark {
case 1...2:
    message = "exam is failed"
case 3...4:
    message = "not bad"
case 5:
    message = "excellent"
default:
    message = "some inappropriate information here"
}

let answer = (code: 404, message: "Page not found")
switch answer {
case (100..<400, _):
    print(answer.message)
case (400..<500, _):
    print(false, answer.message)
default:
    print("some inappropriate information here")
}

//where in switch-statement

let dragonCharacteristics = (weight: 3.9, color:"green")
var dragonCount = 3

switch dragonCharacteristics {
case (..<2, "red"):
    print("cage #1")
case (..<2, "green"):
    print("cage #2")
case (let weight, "green") where weight > 2 && dragonCount < 5 && weight.truncatingRemainder(dividingBy: 1) == 0,
     (let weight, "red") where weight > 2 && dragonCount < 5 && weight.truncatingRemainder(dividingBy: 1) == 0:
    print("cage #3")
default:
    print("some strange reptile its definetly not a dragon maybe rat or smth")
}

//default with break

let someInt = 0
switch someInt {
case 1...:
    print( "more than 0" )
case ..<0:
    print( "less than 0" )
default:
    break
}

//fallthrough

let situation = "B"
switch situation {
case "A":
    print("turn off all electronic devices")
    fallthrough
case "B":
    print("shut the doors")
    fallthrough
case "C":
    print("calm down")
default:
    print("chill out guys nothing happened")
}

//while and repeat-while

var i = 1
var resultSum = 0
while i <= 10 {
    resultSum += i
    i += 1
}
resultSum

var y = 1
var result = 0
repeat {
result += y
    y += 1
} while y <= 10
result

//break in while-statements

var coins = 0
var year = 0
while year < 10 {
    coins += year
    year += 1
    if coins > 5 {
        print("a lot of coins we can stop for now")
        break
    }
}

//for-statement

for oneElementOfArray in [1, 3, 5, 7, 9] {
    print(oneElementOfArray)
}

let array = [1, 3, 5, 7, 9]
for number in array {
    print(number)
}

for letter in "Swift" {
    print(letter)
}

for _ in 1...3 {
    print("repeating line")
}

var countriesAndBlocks = ["Russia": "CIS", "Franve": "EU"]
for (countryName, orgName) in countriesAndBlocks {
    print("\(countryName) joins \(orgName)")
}

print("Facts about me:")
let myMusicStyles = ["Rock", "Jazz", "Pop"]
for (index, musicName) in myMusicStyles.enumerated() {
    print("\(index+1). I love \(musicName)")
}

for i in stride(from: 1, to: 10, by: 3) {
    print(i)
}

//where in for-in statements

for i in stride(from: 1, through: 10, by: 1) where i % 2 == 0 {
    print(i)
}

for i in 1...9 {
    print(i)
}

//continue in for-in statements

for i in 1...10 {
    if i % 2 == 0 {
        continue
    } else {
        print(i)
    }
}

//break in for-in statements


for i in 1... {
    let randNum = Array<Int>(0...100).randomElement()
    if randNum == 5 {
        print("Iteration number \(i)")
break }
}

//mainloop in for-in statements

mainLoop: for i in 1...10 {
    for j in 1...10 {
        if i * j == 25 {
            break mainLoop
        }
        print(i * j)
    }
}

//guard

var number = 5
guard number > 3 else {
    print("no")
}
