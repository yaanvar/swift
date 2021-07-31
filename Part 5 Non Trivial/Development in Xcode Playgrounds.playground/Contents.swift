import UIKit
import PlaygroundSupport

let sizeOfArea = CGSize(width: 400, height: 400)
var area = SquareArea(size: sizeOfArea, color: UIColor.gray)
area.setBalls(withColors: [UIColor.red, UIColor.purple, UIColor.green, UIColor.yellow], andRadius: 30)
PlaygroundPage.current.liveView = area 
