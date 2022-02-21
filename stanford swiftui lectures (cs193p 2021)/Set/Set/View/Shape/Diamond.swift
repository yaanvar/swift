//
//  Diamond.swift
//  Set
//
//  Created by Anvar Rahimov on 21.08.2021.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: bottom)
        path.addLine(to: right)
        path.addLine(to: top)
        path.addLine(to: left)
        
        return path
    }
    
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Diamond().stroke(lineWidth: 7)
            Diamond().fill().foregroundColor(.black)
            Diamond().opacity(0.5)
        }
        .padding()
    }
}
