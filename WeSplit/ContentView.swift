//
//  ContentView.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Section {
                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: Locale.current.currencyCode ?? "USD"),
                    prompt: Text("$0.00")
                )
                .keyboardType(.decimalPad)
                .focused($amountFocused)
                
                ExtendedSegmentedPicker($people, options: Array(2...50)) {
                    Text("\($0) people")
                }
            }
            
            Section("How much tip do you want to leave?") {
                ExtendedSegmentedPicker($tip, options: Array(stride(from: 0.0, through: 0.8, by: 0.05)), startAt: 2) {
                    Text($0, format: .percent)
                }
            }
        }
        .overlay(alignment: .bottom) {
            TotalView(amount: self.amount, people: self.people, tip: self.tip)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done", action: { amountFocused = false })
            }
        }
        .group { $0
            .navigationTitle("WeSplit")
            .embedInNavigation()
            .navigationViewStyle(.stack)
        }
    }
    
    @State private var amount: Double? = nil
    @State private var people = 2
    @State private var tip = 0.2
    
    @FocusState private var amountFocused: Bool
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
