//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

struct Item: Identifiable, Codable, Equatable {
    
    let id: UUID
    
    var name: String,
        kind: Kind
    
    var amount: Double {
        didSet { amount = max(amount, 0) }
    }
    
    init(_ name: String, kind: Kind, amount: Double) {
        self.id = UUID()
        self.name = name
        self.kind = kind
        self.amount = amount
    }
    
}
