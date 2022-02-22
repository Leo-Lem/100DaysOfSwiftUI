//
//  Item-Kind.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

extension Item {
    
    enum Kind: Hashable, Codable {
        case income(Income = .salary),
             expense(Expense = .living)
        
        enum Income: CaseIterable, Hashable, Codable {
            case salary, capitalGains
        }
        
        enum Expense: CaseIterable, Hashable, Codable {
            case living, recreation, business
        }
        
        init(_ income: Income) { self = .income(income) }
        init(_ expense: Expense) { self = .expense(expense) }
    }
    
}
