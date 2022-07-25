//
//  ContentView.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI
import MySwiftUI

struct WeSplitForm: View {
    
    @EnvironmentObject var state: AppState
    var body: some View { Content(vm: ViewModel(state)) }
    
    struct Content: View {
        
        @StateObject var vm: ViewModel
        
        var body: some View {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $vm.wip.total,
                        format: .currency(code: AppState.currencyCode),
                        prompt: Text("$0.00")
                    )
                    .keyboardType(.decimalPad)
                    .focused($isAmountFocused)
                }
                
                Section("How many people?") {
                    ExtendedSegmentedPicker($vm.wip.people, options: Array(Entry.WIP.peopleLimits)) {
                        Text("\($0) people")
                    }
                }
                
                Section("How much do you want to tip?") {
                    let limits = Entry.WIP.tipLimits
                    
                    ExtendedSegmentedPicker(
                        $vm.wip.tip,
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
                    .disabled(!vm.wip.isTotalSet)
                    .frame(maxWidth: .infinity)
                }
            }
            .toolbar {
                KeyboardDoneButton($isAmountFocused)
                
                ToolbarItem(placement: .automatic) {
                    NavigationLink {
                        History(entries: vm.history)
                    } label: {
                        Label("History", systemImage: "list.bullet.circle")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    if let entry = Entry(vm.wip) { Total(entry: entry) }
                }
            }
            .group { $0
                .navigationTitle("WeSplit")
                .embedInNavigation()
                .navigationViewStyle(.stack)
            }
        }
        
        @FocusState private var isAmountFocused: Bool
        
        private func addEntryAndResetForm() {
            vm.addEntry()
            resetForm()
        }
        
        private func resetForm() {
            isAmountFocused = false
            vm.wip = .init()
        }
        
    }
}

// MARK: - (Previews)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitForm()
    }
}
