//
//  Squiggle.swift
//  Set
//
//  Created by Anvar Rahimov on 21.08.2021.
//

import SwiftUI

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let firstCurve = CGPoint(x: rect.midX/2, y: rect.minY)
        
        path.move(to: start)
        path.addCurve(to: firstCurve,
                      control1: <#T##CGPoint#>, control2: <#T##CGPoint#>)
        
        return path
    }
    
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle()
    }
}
