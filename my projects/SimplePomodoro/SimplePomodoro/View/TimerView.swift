//
//  TimerView.swift
//  SimplePomodoro
//
//  Created by Anvar Rahimov on 21.11.2021.
//

import SwiftUI

struct TimerF {
    var workInterval: UInt = 25
    var shortBreakInterval: UInt = 5
    var longBreakInterval: UInt = 30
    var rounds: UInt = 4
    var isWorking: Bool = false
}

//MARK: - TimerView

struct TimerView: View {
    
    @State var fill: CGFloat = 1
    @State var timeRemaining = 65
    @State var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    func timeStamp(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        return "\(minuteStamp):\(secondStamp)"
    }
    var body: some View {
        
        VStack {
            ZStack {
                
                CircleView(fill: fill)
                
                Text(timeStamp(seconds: timeRemaining))
                    .font(.largeTitle.bold())
                    .foregroundColor(.blue)
                    .padding()
            
            }
            .padding()
            
            Button {
                withAnimation(Animation.linear(duration: CGFloat(timeRemaining))) {
                    self.fill = 0
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
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.isActive = true
        }
    }
}

//MARK: - Content Preview

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
