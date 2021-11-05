//
//  Shapes.swift
//  Cards
//
//  Created by Anvar Rahimov on 05.11.2021.
//

import UIKit

//MARK: - Protocols

protocol ShapeLayerProtocol: CAShapeLayer {
    init(size: CGSize, fillColor: CGColor)
}

extension ShapeLayerProtocol {
    init() {
        fatalError("init() не может быть использован для создания экземпляра")
    }
}

//MARK: - Shapes

class CircleShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let radius = ([size.height, size.width].min() ?? 0) / 2
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path.close()
        
        self.path = path.cgPath
        self.fillColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SquareShape: CAShapeLayer, ShapeLayerProtocol {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let edgeSize = ([size.width, size.height].min() ?? 0)
        
        let rect = CGRect(x: 0, y: 0, width: edgeSize, height: edgeSize)
        let path = UIBezierPath(rect: rect)
        path.close()
        
        self.path = path.cgPath
        self.fillColor = fillColor
    }
}

class CrossShape: CAShapeLayer, ShapeLayerProtocol {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.move(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        
        self.path = path.cgPath
        self.lineWidth = 5
        self.strokeColor = fillColor
        
    }
}

class FillShape: CAShapeLayer, ShapeLayerProtocol {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let path = UIBezierPath(rect: rect)
        path.close()
        
        self.path = path.cgPath
        self.fillColor = fillColor
    }
}

//MARK: - BackSides

class BackSideLine: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        let path = UIBezierPath()
        // рисуем 15 линий
        for _ in 1...15 {
            // координаты начала очередной линии
            let randomXStart = Int.random(in: 0...Int(size.width))
            let randomYStart = Int.random(in: 0...Int(size.height))
            // координаты конца очередной линии
            let randomXEnd = Int.random(in: 0...Int(size.width))
            let randomYEnd = Int.random(in: 0...Int(size.height))
            // смещаем указатель к началу линии
            path.move(to: CGPoint(x: randomXStart, y: randomYStart))
            // рисуем линию
            path.addLine(to: CGPoint(x: randomXEnd, y: randomYEnd))
        }
            
        // инициализируем созданный путь
        self.path = path.cgPath
        // изменяем стиль линий
        self.strokeColor = fillColor
        self.lineWidth = 3
        self.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BackSideCircle: CAShapeLayer, ShapeLayerProtocol {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        
        for _ in 1...15 {
            let randomX = Int.random(in: 0...Int(size.width))
            let randomY = Int.random(in: 0...Int(size.height))
            let center = CGPoint(x: randomX, y: randomY)
            
            path.move(to: center)
            let radius = CGFloat(Int.random(in: 5...15))
            path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            
            self.path = path.cgPath
            self.strokeColor = fillColor
            self.fillColor = fillColor
            self.lineWidth = 1
        }
    }
}



