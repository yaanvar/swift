//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Anvar Rahimov on 11.07.2022.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.item.name)
                TextField("Street Address", text: $order.item.streetAddress)
                TextField("City", text: $order.item.city)
                TextField("Zip", text: $order.item.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
