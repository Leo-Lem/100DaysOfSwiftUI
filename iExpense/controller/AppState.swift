//
//  Expenses.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation
import MyStorage
import MyCollections

@MainActor class AppState: ObservableObject {
    
    @Published var items: [Item] = .load() ?? [] {
        didSet { items.save() }
    }
    
}

extension AppState {
    
    func editItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        } else { items.append(item) }
    }
    func removeItem(_ item: Item) { items.removeAll { $0 == item } }
    func removeItems(at offsets: IndexSet) { items.remove(atOffsets: offsets) }
    
}

//MARK: - persistence
fileprivate extension Array where Element == Item {
    private static let file = "items"
    func save() { try? FileManager.default.save(self, file: Self.file) }
    static func load() -> Self? { try? FileManager.default.load(file) }
}
