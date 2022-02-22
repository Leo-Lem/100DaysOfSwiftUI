//
//  Item-Kind-name.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

extension Item.Kind: CaseIterable {
    static let allCases: [Item.Kind] = [.income(), .expense()],
               allIncomeCases: [Item.Kind] = Income.allCases.map(Self.init),
               allExpenseCases: [Item.Kind] = Expense.allCases.map(Self.init)
    
    var allCases: [Self] {
        switch self {
        case .income: return Item.Kind.allIncomeCases
        case .expense: return Item.Kind.allExpenseCases
        }
    }
    
    var label: String {
        switch self {
        case .income: return "Income"
        case .expense: return "Expense"
        }
    }
    
    var specificLabel: String {
        switch self {
        case .income(let kind): return kind.label
        case .expense(let kind): return kind.label
        }
    }
    
}

extension Item.Kind.Income {
    var label: String {
        switch self {
        case .salary: return "Salary"
        case .capitalGains: return "Capital Gains"
        }
    }
}

extension Item.Kind.Expense {
    var label: String {
        switch self {
        case .business: return "Business"
        case .living: return "Living"
        case .recreation: return "Recreation"
        }
    }
}
