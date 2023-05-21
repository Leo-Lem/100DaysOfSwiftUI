//
//  Item-Kind.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation
import MyOthers

extension Item {
    
    enum Kind: CaseIterable, Hashable, Codable, Equatable {
        case salary, capitalGains
        case living, recreation, business
        
        var category: Category {
            get { (cases.first(where: { $0.value.contains(self) })?.key)!  }
            set { self = (cases[newValue]?.first)! }
        }
        
        var cases: [Category: [Kind]] {[
                .income: [.salary, .capitalGains],
                .expense: [.living, .recreation, .business]
        ]}
        
        enum Category: CaseIterable {
            case income, expense
        }
    }
    
}
