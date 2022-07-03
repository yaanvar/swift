//
//  ContentView.swift
//  Animations
//
//  Created by Anvar Rahimov on 03.07.2022.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    
    let letters = Array("Hello, SwiftUI!")
    
    var body: some View {
        
//      MARK: - Building custom transitions using ViewModifier
        
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
//      MARK: - Showing and hiding views with transitions
//
//        Button("Tap me") {
//            withAnimation {
//                isShowingRed.toggle()
//            }
//        }
//
//        if isShowingRed {
//            Rectangle()
//                .fill(.red)
//                .frame(width: 200, height: 200)
//                .transition(.asymmetric(insertion: .scale, removal: .opacity))
//        }
        
//      MARK: - Animating gestures
//
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(
//                        .default
//                            .delay(Double(num) / 20),
//                        value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged{ value in
//                    dragAmount = value.translation
//                }
//                .onEnded { value in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )

//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        dragAmount = value.translation
//                    }
//                    .onEnded{ _ in
//                        dragAmount = .zero
//                    }
//            )
//            .animation(.spring(), value: dragAmount)
        
        
//      MARK: - Controlling the animation stack
//        Button("Tap me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .blue : .red)
//        .animation(.default, value: enabled)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
        
        
//        MARK: - 3D animations
//        Button("Tap me") {
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                animationAmount += 360
//            }
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

//        MARK: - Animating value
//        VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .spring()
//                .repeatCount(3, autoreverses: true)
//            ), in:  1...10)
//
//            Spacer()
//
//            Button("Tap me") {
//                animationAmount += 1
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
//        .padding()
        
        
//        MARK: - Button
//        Button("Tap me") {
//            animationAmount += 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: false),
//                    value: animationAmount
//                )
//        )
//        .onAppear {
//            animationAmount = 2
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
