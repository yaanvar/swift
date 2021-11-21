//
//  TimerView.swift
//  SimplePomodoro
//
//  Created by Anvar Rahimov on 21.11.2021.
//

import SwiftUI

struct Timer {
    var workInterval: UInt = 25
    var shortBreakInterval: UInt = 5
    var longBreakInterval: UInt = 30
    var rounds: UInt = 4
    var isWorking: Bool = false
}

//MARK: - TimerView

struct TimerView: View {
    
    @State var fill: CGFloat = 0
    @State var time: Int = 1000
    
    func timeStamp(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds / 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? minutes : "0" + seconds
        return "\(minuteStamp):\(secondStamp)"
    }
    var body: some View {
        
        VStack {
            ZStack {
                CircleView(fill: fill)
                
                Text(timeStamp(seconds: time))
            }
            
            Button {
                withAnimation(Animation.linear(duration: CGFloat(time))) {
                    for i in 0...100 {
                        self.fill += Double(i) * 0.01
                    }
                }
            } label: {
                Label("Start", systemImage: "play")
            }
            .padding()
            
            Button {
                self.fill = self.fill
            } label: {
                Label("Pause", systemImage: "pause")
            }
        }
    }
}

//MARK: - Content Preview

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
