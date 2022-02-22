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
        List {
            ForEach(state.items.reversed()) { item in
                ItemView(item: item)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) { state.removeItem(item)}
                        Button("Edit") { currentItem = item }
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
            }
            .onDelete { state.removeItems(at: $0) }
        }
        
        .navigationTitle("iExpense")
        .toolbar {
            ToolbarItem { EditButton() }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(systemImage: "plus") { currentItem = Item("", kind: .expense(.living), amount: 0) }
            }
        }
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
    
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
