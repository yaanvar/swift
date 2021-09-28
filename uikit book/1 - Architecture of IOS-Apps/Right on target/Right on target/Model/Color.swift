//
//  Color.swift
//  Right on target
//
//  Created by Anvar Rahimov on 28.09.2021.
//

import UIKit

protocol ColorProtocol {
    var red: UInt8 { get set }
    var green: UInt8 { get set }
    var blue: UInt8 { get set }
    
    init(from: UIColor)
    func getByHEXString() -> String
    func getByUIColor() -> UIColor
}

struct Color: ColorProtocol, Equatable {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    
    init(from color: UIColor) {
        red = UInt8(CGFloat(255) * color.cgColor.components![0])
        green = UInt8(CGFloat(255) * color.cgColor.components![1])
        blue = UInt8(CGFloat(255) * color.cgColor.components![2])
    }
    
    init() {
        red = 0
        green = 0
        blue = 0
    }
    
    func getByHEXString() -> String {
        var redPart = String(red, radix: 16, uppercase: true)
        if red <= 16 {
            redPart = "0\(redPart)"
        }
        var greenPart = String(green, radix: 16, uppercase: true)
        if green <= 16 {
            greenPart = "0\(greenPart)"
        }
        var bluePart = String(blue, radix: 16, uppercase: true)
        if blue <= 16 {
            bluePart = "0\(bluePart)"
        }
        return "\(redPart)\(greenPart)\(bluePart)"
    }
    
    func getByUIColor() -> UIColor {
        let redFloat: Float = Float(red)/255
        let greenFloat: Float = Float(green)/255
        let blueFloat: Float = Float(blue)/255
        return UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue: CGFloat(blueFloat), alpha: 1)
    }
}
