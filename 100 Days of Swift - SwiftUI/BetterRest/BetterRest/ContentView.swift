//
//  ContentView.swift
//  BetterRest
//
//  Created by Anvar Rahimov on 02.07.2022.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var somethingChanged = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                    .font(.headline)
                
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section {
                    Text("Your ideal bedtime is \(alertMessage == "" ? "..." : alertMessage)")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("BetterRest")
//                    .toolbar {
//                        Button("Calculate", action: calculateBedTime)
//                    }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .onChange(of: coffeeAmount) { _ in
                calculateBedTime()
            }
            .onChange(of: wakeUp) { _ in
                calculateBedTime()
            }
            .onChange(of: sleepAmount) { _ in
                calculateBedTime()
            }
        }
    }
        
    
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
             
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            //alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculation your bedtime."
            showingAlert = true
        }
//        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
