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
            }
            
            Section("How many people?") {
                ExtendedSegmentedPicker($people, options: Array(2...50)) {
                    Text("\($0) people")
                }
            }
            
            Section("How much do you want to tip?") {
                ExtendedSegmentedPicker($tip, options: Array(stride(from: 0.0, through: 0.8, by: 0.05)), startAt: 2) {
                    Text($0, format: .percent)
                }
            }
            
            Section {
                Button {
                    guard let total = total else { return }
                    state.saveEntry(total: total, people: people, tip: tip)
                    self.total = nil
                    self.people = 2
                    self.tip = 0.2
                } label: {
                    Label("Pay", systemImage: "signature")
                }
                .disabled(total == nil)
                .frame(maxWidth: .infinity)
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                NavigationLink {
                    History(entries: state.history)
                } label: {
                    Label("History", systemImage: "list.bullet.circle")
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                if let total = total { Total(amount: total, people: people, tip: tip) }
            }
            
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
