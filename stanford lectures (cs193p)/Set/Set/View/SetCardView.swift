//
//  SetCardView.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import SwiftUI

struct SetCardView: View {
    var card: SetCard
    var colors: [Color] = [.green, .red, .purple]
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach(0..<card.number.rawValue) { index in
                    cardShape()
                        .frame(height: geometry.size.height / 3)
                }
                Spacer()
            }
        }
        .padding(40)
        .foregroundColor(colors[card.color.rawValue - 1])
        .aspectRatio(2/3, contentMode: .fit)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: lineWidth)
                .padding()
        )
    }
    
    private func cardShape() -> some View {
        ZStack {
            switch card.shape {
            case .v1:
                shapeFill(shape: Diamond())
            case .v2:
                shapeFill(shape: Squiggle())
            case .v3:
                shapeFill(shape: Capsule())
            }
        }
    }
    
    private func shapeFill<setShape>(shape: setShape) -> some View where setShape: Shape {
        ZStack {
            switch card.fill {
            case .v1:
                shape.stroke(lineWidth: lineWidth)
            case .v2:
                shape.fillAndBorder(lineWidth)
            case .v3:
                shape.stripe(lineWidth)
            }
        }
    }
    
    //MARK: - Drawing constants
    private let lineWidth: CGFloat = 3
    private let opacity: Double = 0.5
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardView(card: SetCard(shape: .v2,
                            fill: .v3,
                            color: .v2,
                            number: .v3))
    }
}
