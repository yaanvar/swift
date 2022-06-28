//
//  ContentView.swift
//  ConverterApp
//
//  Created by Anvar Rahimov on 28.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tempertureNumber = 0.0
    @State private var systemConvertFromPicked = "Celcius"
    @State private var systemConverInPicked = "Fahrenheit"
    @FocusState private var tempertureNumberIsFocused: Bool
    
    var conversionSystem = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var finalTemperture: Double {
        var temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.celsius)
        if systemConvertFromPicked == "Celcius" && systemConverInPicked == "Fahrenheit" {
            temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.celsius)
            temperture = temperture.converted(to: UnitTemperature.fahrenheit)
        } else if systemConvertFromPicked == "Celcius" && systemConverInPicked == "Kelvin" {
            temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.celsius)
            temperture = temperture.converted(to: UnitTemperature.kelvin)
        } else if systemConvertFromPicked == "Fahrenheit" && systemConverInPicked == "Celcius" {
            temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.fahrenheit)
            temperture = temperture.converted(to: UnitTemperature.celsius)
        } else if systemConvertFromPicked == "Fahrenheit" && systemConverInPicked == "Kelvin" {
            temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.fahrenheit)
            temperture = temperture.converted(to: UnitTemperature.kelvin)
        } else if systemConvertFromPicked == "Kelvin" && systemConverInPicked == "Fahrenheit" {
            temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.kelvin)
            temperture = temperture.converted(to: UnitTemperature.fahrenheit)
        } else if systemConvertFromPicked == "Kelvin" && systemConverInPicked == "Celcius" {
            temperture = Measurement(value: tempertureNumber, unit: UnitTemperature.kelvin)
            temperture = temperture.converted(to: UnitTemperature.celsius)
        }
        
        return temperture.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperture number", value: $tempertureNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempertureNumberIsFocused)
                } header: {
                    Text("Temperture")
                }
                
                Section {
                    Picker("Convert from", selection: $systemConvertFromPicked) {
                        ForEach(conversionSystem, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Convert to", selection: $systemConverInPicked) {
                        ForEach(conversionSystem, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Convertion")
                }
                
                Section {
                    Text("\(finalTemperture.formatted())")
                } header: {
                    Text("Converted Temperture")
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        tempertureNumberIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
