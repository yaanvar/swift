//
//  ViewController.swift
//  Project27
//
//  Created by Anvar Rahimov on 24.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func redrawTapped(_ sender: Any) {
        if currentDrawType > 7 {
            currentDrawType = 0
        }

        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        case 7:
            drawTwin()
        default:
            break
        }
        
        currentDrawType += 1
    }
    
    func drawRectangle() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addRect(rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }

    func drawCircle() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addEllipse(in: rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            context.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col).isMultiple(of: 2) {
                        context.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            context.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations {
                context.cgContext.rotate(by: amount)
                context.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            context.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                context.cgContext.rotate(by: .pi / 2)
                
                if first {
                    context.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    context.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = image
    }
    
    func drawEmoji() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { context in
            context.cgContext.translateBy(x: 256, y: 256)
            
            let face = CGRect(x: -100, y: -100, width: 200, height: 200).insetBy(dx: 5, dy: 5)
            context.cgContext.setFillColor(UIColor.yellow.cgColor)
            context.cgContext.setStrokeColor(UIColor.orange.cgColor)
            context.cgContext.setLineWidth(7)
            context.cgContext.addEllipse(in: face)
            context.cgContext.drawPath(using: .fillStroke)
            
            let mouth = CGRect(x: -20, y: 25, width: 40, height: 40)
            context.cgContext.setFillColor(UIColor.brown.cgColor)
            context.cgContext.addEllipse(in: mouth)
            context.cgContext.drawPath(using: .fill)
            
            let leftEye = CGRect(x: -45, y: -35, width: 25, height: 30)
            context.cgContext.setFillColor(UIColor.brown.cgColor)
            context.cgContext.addEllipse(in: leftEye)
            context.cgContext.drawPath(using: .fill)
            
            let rightEye = CGRect(x: 20, y: -35, width: 25, height: 30)
            context.cgContext.setFillColor(UIColor.brown.cgColor)
            context.cgContext.addEllipse(in: rightEye)
            context.cgContext.drawPath(using: .fill)
        }
        
        imageView.image = image
    }
    
    func drawTwin() {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
            
            let img = renderer.image { context in
                context.cgContext.translateBy(x: 0, y: 256)
            
                context.cgContext.setStrokeColor(UIColor.black.cgColor)
                context.cgContext.setLineWidth(1)
                
                context.cgContext.move(to: CGPoint(x: 30, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 106, y: 40))
                context.cgContext.move(to: CGPoint(x: 70, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 70, y: 158))
                
                context.cgContext.move(to: CGPoint(x: 121, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 146, y: 158))
                context.cgContext.move(to: CGPoint(x: 146, y: 158))
                context.cgContext.addLine(to: CGPoint(x: 174, y: 40))
                context.cgContext.move(to: CGPoint(x: 174, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 199, y: 158))
                context.cgContext.move(to: CGPoint(x: 199, y: 158))
                context.cgContext.addLine(to: CGPoint(x: 227, y: 40))
                
                context.cgContext.move(to: CGPoint(x: 251, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 251, y: 158))
                
                context.cgContext.move(to: CGPoint(x: 286, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 286, y: 158))
                context.cgContext.move(to: CGPoint(x: 286, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 347, y: 158))
                context.cgContext.move(to: CGPoint(x: 347, y: 40))
                context.cgContext.addLine(to: CGPoint(x: 347, y: 158))
                
                context.cgContext.drawPath(using: .fillStroke)
            }
            imageView.image = img
        }
    
}

