//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Anvar Rahimov on 11.07.2022.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.item.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.item.quantity)", value: $order.item.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.item.specialRequestEnabled.animation())
                    
                    if order.item.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.item.extraFrosting)
                        Toggle("Add extrasprinkles", isOn: $order.item.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
