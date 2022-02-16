//
//  ContentView.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Section {
                TextField(
                    "Amount",
                    value: $total,
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
            
            Section {
                Button {
                    guard let total = total else { return }
                    state.saveEntry(total: total, people: people, tip: tip)
                } label: {
                    Label("Pay", systemImage: "signature")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .overlay(alignment: .bottom) {
            Total(amount: total, people: people, tip: tip)
                .background(.bar)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done", action: { amountFocused = false })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    History(entries: state.history)
                } label: { Label("History", systemImage: "list.bullet.circle")}
            }
        }
        .group { $0
            .navigationTitle("WeSplit")
            .embedInNavigation()
            .navigationViewStyle(.stack)
        }
    }
    
    @State private var total: Double? = nil
    @State private var people = 2
    @State private var tip = 0.2
    
    @FocusState private var amountFocused: Bool
    
    @StateObject private var state = AppState()
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
