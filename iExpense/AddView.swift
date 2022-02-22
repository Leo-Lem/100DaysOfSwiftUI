//
//  AddView.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 14.08.21.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @ObservedObject var expenses: Expenses
    
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    static let types = ["Business", "Personal"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(
                trailing:
                    Button("Save"){
                        if let actualAmount = Int(amount) {
                            let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                            expenses.items.append(item)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            errorMessage = "Invalid amount. \n Please enter a full-dollar value!"
                            showingAlert = true
                        }
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("Try again")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
