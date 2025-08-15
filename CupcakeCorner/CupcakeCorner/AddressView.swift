//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Tiago Camargo Maciel dos Santos on 06/06/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.deliveryAddress.name)
                TextField("Street Address", text: $order.deliveryAddress.streetAddress)
                TextField("City", text: $order.deliveryAddress.city)
                TextField("Zip", text: $order.deliveryAddress.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(!order.hasValidAddress)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
