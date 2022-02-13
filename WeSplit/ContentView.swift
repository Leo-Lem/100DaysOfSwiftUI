//
//  ContentView.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 27.07.21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 0
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var noTip: Bool {
        if tipPercentage == 4 { return true }
        return false
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0 + 2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount * tipSelection/100
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var total: Double {
        let peopleCount = Double(numberOfPeople) ?? 0 + 2
        
        return totalPerPerson * peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total")) {
                    Text("$ \(total, specifier: "%.2f")").foregroundColor(noTip ? .red: .primary)
                }
                
            }
            .navigationBarTitle("WeSplit!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
