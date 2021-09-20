//
//  Squiggle.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import SwiftUI

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var pathUpper = Path()
        
        let sqdx = rect.width * 0.1
        let sqdy = rect.height * 0.2
        
        pathUpper.move(to: CGPoint(x: rect.minX ,y: rect.midY))
        
        pathUpper.addCurve(to: CGPoint(x: rect.minX + rect.width * 1/2,
                                  y: rect.minY + rect.height / 8),
                      control1: CGPoint(x: rect.minX, y: rect.minY),
                      control2: CGPoint(x: rect.minX + rect.width * 1/2 - sqdx,
                                        y: rect.minY + rect.height / 8 - sqdy))
        
        pathUpper.addCurve(to: CGPoint(x: rect.minX + rect.width * 4/5,
                                  y: rect.minY + rect.height / 8),
                      control1: CGPoint(x: rect.minX + rect.width * 1/2 + sqdx,
                                        y: rect.minY + rect.height / 8 + sqdy),
                      control2: CGPoint(x: rect.minX + rect.width * 4/5 - sqdx,
                                        y: rect.minY + rect.height / 8 + sqdy))

        pathUpper.addCurve(to: CGPoint(x: rect.minX + rect.width,
                                  y: rect.minY + rect.height / 2),
                      control1: CGPoint(x: rect.minX + rect.width * 4/5 + sqdx,
                                        y: rect.minY + rect.height / 8 - sqdy),
                      control2: CGPoint(x: rect.minX + rect.width,
                                        y: rect.minY))

        var pathLower = pathUpper
        
        pathLower = pathLower.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        pathLower = pathLower.applying(CGAffineTransform.identity
                                        .translatedBy(x: rect.size.width, y: rect.size.height))
        
        pathUpper.move(to: CGPoint(x: rect.minX, y: rect.midY))
        pathUpper.addPath(pathLower)
        
        return pathUpper
    }
    
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Squiggle().stroke(lineWidth: 7)
            Squiggle().fill().foregroundColor(.black)
            Squiggle().opacity(0.5)
        }
        .padding()
    }
}
