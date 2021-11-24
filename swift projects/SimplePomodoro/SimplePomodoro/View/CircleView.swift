//
//  CircleView.swift
//  SimplePomodoro
//
//  Created by Anvar Rahimov on 21.11.2021.
//

import SwiftUI

//MARK: - Circles

struct BackgroundCircle: View {
    var body: some View {
        Circle()
            .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 50))
            .padding(50)
    }
}

struct MainCircle: View {
    var fill: CGFloat = 0
    
    let lightBlue = Color(red: 0, green: 0.8, blue: 1)
    let darkBlue = Color(red: 0, green: 0.8, blue: 1)
    
    let gradient = Gradient(colors: [Color(red: 0, green: 0.7, blue: 1), Color(red: 0, green: 0.1, blue: 1)])
    
    var body: some View {
        Circle()
            .trim(from: 0, to: self.fill)
            .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .miter, miterLimit: 20))
            .fill(AngularGradient(gradient: gradient, center: .center))
            .padding(50)
            .rotationEffect(.init(degrees: -90))
    }
}

//MARK: - CircleView

struct CircleView: View {
    var fill: CGFloat
    
    var body: some View {
        ZStack {
            BackgroundCircle()
            MainCircle(fill: fill)
        }
    }
}

//MARK: - Content View

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CircleView(fill: 0.5)
        }
    }
}
