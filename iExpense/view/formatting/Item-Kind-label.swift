//
//  Item-Kind-name.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

extension Item.Kind {
    
    var label: String {
        switch self {
        case .salary: return "Salary"
        case .capitalGains: return "Capital Gains"
        case .business: return "Business"
        case .living: return "Living"
        case .recreation: return "Recreation"
        }
    }
    
}

extension Item.Kind.Category {
    
    var label: String {
        switch self {
        case .income: return "Income"
        case .expense: return "Expense"
        }
    }
    
}
