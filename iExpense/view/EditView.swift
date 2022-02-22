//
//  EditView.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import SwiftUI
import MySwiftUI

struct EditView: View {
    let editItem: (Item?) -> Void
    
    var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $item.name)
                    .focused($focus, equals: .name)
                
                Picker("", selection: $item.kind, items: item.kind.allCases, id: \.self) { Text($0.specificLabel) }
                
                Picker("", selection: $item.kindCategory, items: Item.Kind.allCases, id: \.self) { Text($0.label) }
                
                let code = Locale.current.currencyCode ?? "USD"
                TextField(
                    0.formatted(.currency(code: code)),
                    value: $item.amount,
                    format: .currency(code: code)
                )
                .foregroundColor(item.amountColor)
                .keyboardType(.decimalPad)
                .focused($focus, equals: .amount)
            }
            .pickerStyle(.segmented)
            .multilineTextAlignment(.center)
            
            if !item.name.isEmpty {
                Section("Preview") { ItemView(item: item) }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Save") { editItem(item) }
                    .disabled(item.name.isEmpty)
            }
            
            KeyboardDoneButton { focus = nil }
        }
    }
    
    @State private var item: Item
    
    @FocusState private var focus: Field?
    enum Field: Hashable { case name, amount }
    
    init(_ item: Item, editItem: @escaping (Item?) -> Void) {
        self.editItem = editItem
        self._item = State(initialValue: item)
    }
}

#if DEBUG
//MARK: - Previews
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(.example) { _ in }
            .embedInNavigation()
    }
}
#endif
