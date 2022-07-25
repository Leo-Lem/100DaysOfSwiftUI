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
                    value: $wip.total,
                    format: .currency(code: Locale.current.currencyCode ?? "USD"),
                    prompt: Text("$0.00")
                )
                .keyboardType(.decimalPad)
                .focused($isAmountFocused)
            }
            
            Section("How many people?") {
                ExtendedSegmentedPicker($wip.people, options: Array(Entry.WIP.peopleLimits)) {
                    Text("\($0) people")
                }
            }
            
            Section("How much do you want to tip?") {
                let limits = Entry.WIP.tipLimits
                
                ExtendedSegmentedPicker(
                    $wip.tip,
                    options: Array(stride(from: limits.lowerBound, through: limits.upperBound, by: 0.05)),
                    startAt: 2
                ) {
                    Text($0, format: .percent)
                }
            }
            
            Section {
                Button(action: addEntryAndResetForm) {
                    Label("Pay", systemImage: "signature")
                }
                .disabled(!wip.isTotalSet)
                .frame(maxWidth: .infinity)
            }
        }
        .toolbar {
            KeyboardDoneButton($isAmountFocused)
            
            ToolbarItem(placement: .automatic) {
                NavigationLink {
                    History(entries: state.history)
                } label: {
                    Label("History", systemImage: "list.bullet.circle")
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                if let entry = Entry(wip) { Total(entry: entry) }
            }
        }
        .group { $0
            .navigationTitle("WeSplit")
            .embedInNavigation()
            .navigationViewStyle(.stack)
        }
    }
    
    @State private var wip = Entry.WIP()
    @StateObject private var state = AppState()
    @FocusState private var isAmountFocused: Bool
    
}

extension ContentView {
    
    private func addEntryAndResetForm() {
        guard wip.isTotalSet else { return }
        state.addEntry(wip)
        
        resetForm()
    }
    
    private func resetForm() {
        isAmountFocused = false
        wip = .init()
    }
    
}

// MARK: - (Previews)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
