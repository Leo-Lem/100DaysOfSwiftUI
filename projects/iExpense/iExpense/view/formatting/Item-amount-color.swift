//
//  Item-amount-color.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import SwiftUI

extension Item {
    var amountColor: Color {
        switch self.kind.category {
        case .income:
            switch self.amount {
            case 0: return .primary
            case 0..<10: return .blue
            case 10...: return .green
            default: return .primary
            }
        case .expense:
            switch self.amount {
            case 0: return .primary
            case 0..<10: return .yellow
            case 10...: return .red
            default: return .primary
            }
        }
    }
}
