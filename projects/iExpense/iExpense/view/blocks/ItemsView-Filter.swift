//
//  ItemsView-Filter.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

extension ItemsView {
    
    enum Filter: CaseIterable, Equatable {
        case none, income, salary, capitalGains, expense, living, recreation, business
        
        var label: String {
            switch self {
            case .none: return "No Filter"
            case .income: return "Income"
            case .salary: return "Salary"
            case .capitalGains: return "Capital Gains"
            case .expense: return "Expenses"
            case .living: return "Living"
            case .recreation: return "Recreation"
            case .business: return "Business"
            }
        }
        
        func filter(_ items: [Item]) -> [Item] {
            switch self {
            case .none: return items
            case .income: return items.filter { $0.kind.category == .income }
            case .salary: return items.filter { $0.kind == .salary }
            case .capitalGains: return items.filter { $0.kind == .capitalGains }
            case .expense: return items.filter { $0.kind.category == .expense }
            case .living: return items.filter { $0.kind == .living }
            case .recreation: return items.filter { $0.kind == .recreation }
            case .business: return items.filter { $0.kind == .business }
            }
        }
    }
    
}
