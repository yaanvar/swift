import UIKit

let str = "123"
str.count

//unicod scalar

let char: Character = "\u{E9}"
let anotherChar: Character = "\u{65}\u{301}"
anotherChar == char

//emoji

let thumbsUp = "\u{1f44d}" // "     "
let skinColor = "\u{1f3ff}" // "
let combine = "\u{1f44d}\u{1f3fb}" // "   "

//

let cafeSimple = "caf\u{E9}"
let cafeCombine = "cafe\u{301}"
cafeSimple.count
cafeCombine.count 
//startIndex

let name = "e\u{301}lastic"
let index = name.startIndex
let firstChar = name[index]
type(of: firstChar)
type(of: index)

//endIndex

let nextChar = name.endIndex
let lastChar = name.index(before: nextChar)
name[lastChar]

let secondChar = name.index(after: index)
name[secondChar]

//offSetBy

let fourthChar = name.index(name.startIndex, offsetBy: 3)
name[fourthChar]

//unicodeScalars

name.count
name.unicodeScalars.count

//substring

let alphabet = "abcdefghijklmnopqrstuvwxyz"
let firstCharIndex = alphabet.startIndex
let fourthCharIndex = alphabet.index(firstCharIndex, offsetBy: 3)
let subAlphabet = alphabet[firstCharIndex...fourthCharIndex]
type(of: subAlphabet)
let strSubAlphabet = String(subAlphabet)
type(of: strSubAlphabet)

let subRestOfAlphabet = alphabet[fourthCharIndex...]

