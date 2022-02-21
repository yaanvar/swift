//
//  ExtensionsForShape.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import SwiftUI

extension Shape {
    func stripe(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            Striped().stroke().clipShape(self)
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    func blur(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            self.fill().opacity(0.25)
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    func fillAndBorder(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            self.fill()
            self.stroke(lineWidth: lineWidth)
        }
    }
}
