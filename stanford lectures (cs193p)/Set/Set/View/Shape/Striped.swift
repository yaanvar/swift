//
//  Striped.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import SwiftUI

struct Striped: Shape {
    var spacing: CGFloat = 5
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.minY)
        
        var path = Path()
        
        path.move(to: start)
        while path.currentPoint!.x < rect.maxX {
            path.addLine(to: CGPoint(x: path.currentPoint!.x, y: rect.maxY))
            path.move(to: CGPoint(x: path.currentPoint!.x + spacing, y: rect.minY))
        }
        
        return path
    }
}

struct Striped_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Striped().stroke().clipShape(Diamond())
            Diamond().stroke(lineWidth: 2)
        }
        .padding()
    }
}
