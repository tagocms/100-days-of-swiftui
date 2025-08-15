//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tiago Camargo Maciel dos Santos on 09/06/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var isShowingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage( url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(confirmationTitle, isPresented: $isShowingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order.")
            return
        }
        
        print(encoded)
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "X-API-Key")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            print(data)
            
            do {
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                
                confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes has been placed and is on its way!"
                confirmationTitle = "Confirmation"
                isShowingConfirmation = true
            } catch {
                print("Check out failed due to a problem decoding the data.")
                confirmationMessage = "Check out failed due to a problem decoding the data."
                confirmationTitle = "Error"
                isShowingConfirmation = true
            }
            
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            print("URL: \(url)")
            confirmationMessage = "Check out failed due to a problem communicating with the server."
            confirmationTitle = "Error"
            isShowingConfirmation = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
