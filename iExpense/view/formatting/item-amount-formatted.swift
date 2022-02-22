//
//  item-amount-formatted.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import Foundation

extension Item {
    var formattedAmount: String {
        switch self.kind {
        case .income: return self.amount.formatted(.currency(code: Locale.current.currencyCode ?? "USD"))
        case .expense:
            if self.amount == 0 {
                return self.amount.formatted(.currency(code: Locale.current.currencyCode ?? "USD"))
            } else {
                return (-self.amount).formatted(.currency(code: Locale.current.currencyCode ?? "USD"))
            }
        }
    }
}
