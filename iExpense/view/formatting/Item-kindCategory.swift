//
//  Item-Kind-Category.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

extension Item {
    
    var kindCategory: Kind {
        get {
            switch self.kind {
            case .income: return .income()
            case .expense: return .expense()
            }
        }
        
        set { self.kind = newValue }
    }
    
}
