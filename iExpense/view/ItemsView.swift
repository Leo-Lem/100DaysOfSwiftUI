//
//  ItemsView.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import SwiftUI
import MySwiftUI

struct ItemsView: View {
    var body: some View {
        Group {
            let items = filter.filter(state.items).reversed()
            if items.isEmpty {
                Text("Nothing to see here")
            } else {
                List {
                    ForEach(items) { item in
                        ItemView(item: item)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Delete", role: .destructive) { state.removeItem(item)}
                                Button("Edit") { currentItem = item }
                            }
                    }
                    .onDelete { state.removeItems(at: $0) }
                }
            }
        }
        .sheet(item: $currentItem) {
            EditView($0, editItem: editItem)
                .navigationTitle(currentItem?.name.isEmpty ?? true ? "Add Entry" : "Edit Entry")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !(currentItem?.name.isEmpty ?? true) { Button("Cancel") { editItem(nil) } }
                    }
                }
                .embedInNavigation()
                .navigationViewStyle(.stack)
        }
        .navigationTitle("iExpense")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(systemImage: "plus") { currentItem = Item("", kind: .living, amount: 0) }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Picker("", selection: $filter, items: Filter.allCases, id: \.self) { Text($0.label) }
            }
            
#if DEBUG
ToolbarItem(placement: .bottomBar) {
    Button("Add Entries") {
        for i in 0..<10 {
            state.editItem(Item(
                "Item #\(i)",
                kind: Item.Kind.allCases.randomElement()!,
                amount: Double.random(in: 1...1000)
            ))
        }
    }
}
#endif
        }
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
    
    @State private var filter: Filter = .none
    
    @State private var currentItem: Item? = nil
    
    @StateObject private var state = AppState()
}

extension ItemsView {
    
    private func editItem(_ item: Item?) {
        if let item = item { state.editItem(item) }
        currentItem = nil
    }
    
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
