import UIKit

enum CurrencyUnit {
    case rouble
    case euro, dollar
}

var russianCurrency: CurrencyUnit = .rouble
var otherCurrency = CurrencyUnit.rouble
otherCurrency = .dollar

//

enum AdvancedCurrencyUnit {
    enum DollarCountries {
        case usa
        case canada
        case australia
    }
    case rouble(countries: [String], shortName: String)
    case euro(countries: [String], shortName: String)
    case dollar (DollarCountries, String)
}

var advancedRussianCurrency = AdvancedCurrencyUnit.rouble(countries: ["Russia"], shortName: "rub")

var dollarCurrency: AdvancedCurrencyUnit = .dollar(.usa, "usd")
let euroCurrency: AdvancedCurrencyUnit =  .euro(countries: ["German", "France"], shortName: "EUR")
let australia: AdvancedCurrencyUnit.DollarCountries = .australia

//switch

switch dollarCurrency {
case .rouble:
    print("Rouble")
case let .euro(countries, shortName):
    print("Countries: \(countries), short name: \(shortName)")
case .dollar(let nation, let shortName):
    print("\(nation), short name: \(shortName)")
}

//binded enum

enum Smile: String {
    case joy = ":)"
    case laugh = ":D"
    case sorrow = ":("
    case surprise = "o_O"
    var description: String { return self.rawValue }
    func about() {
        print("this is set of smiles")
    }
    func descriptionValue() -> Smile {
        return self
    }
    func descriptionRawValue() -> String {
        return rawValue
    }
}
let iAmHappy: Smile = .joy
iAmHappy.rawValue

enum Planet: Int {
      case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto = 999
}

var venus = Planet.venus
venus.rawValue

//init

let myPlanet = Planet.init(rawValue: 3)
myPlanet
var anotherPlanet = Planet.init(rawValue: 11)
anotherPlanet

//

var mySmile: Smile = .sorrow
mySmile.description
mySmile.about()
mySmile.descriptionValue()
mySmile.descriptionRawValue()

//reccursive

enum ArithmeticExpression {
    case addition(Int, Int)
    case subtraction(Int, Int)
    func evaluate() -> Int {
        switch self {
        case .addition(let right, let left):
            return right + left
        case .subtraction(let right, let left):
            return right + left
        }
    }
}
let expr = ArithmeticExpression.addition(5, 2)
expr.evaluate()

enum AdvancedArithmeticExpression {
    case number(Int)
    indirect case addition(AdvancedArithmeticExpression, AdvancedArithmeticExpression)
    indirect case subtraction(AdvancedArithmeticExpression, AdvancedArithmeticExpression)
    func evaluate(_ expression: AdvancedArithmeticExpression? = nil) -> Int {
        switch expression ?? self {
        case let .number(value):
            return value
        case let .addition(valueLeft, valueRight):
            return evaluate(valueLeft) + evaluate(valueRight)
        case .subtraction(let valueLeft, let valueRight):
                return evaluate(valueLeft) - evaluate(valueRight)
        }
    }
}

let hardExpr = AdvancedArithmeticExpression.addition(.number(20), .subtraction(.number(10), .number(34)))
hardExpr.evaluate()
