//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Leopold Lemmermann on 08.10.21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var message = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.data.cost, specifier: "%.2f")")
                    
                    Button("Place Order") {
                        Task {
                            await placeOrder()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(message), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Oops!"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let data = try await URLSession.shared.upload(for: request, from: encoded).0
            let decodedOrder = try JSONDecoder().decode(Order.OrderData.self, from: data)
            self.message = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            self.showingConfirmation = true
        } catch is DecodingError {
            self.message = "Invalid response from server"
            self.showingError = true
        } catch {
            self.message = "No data in response: \(error.localizedDescription)."
            self.showingError = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
