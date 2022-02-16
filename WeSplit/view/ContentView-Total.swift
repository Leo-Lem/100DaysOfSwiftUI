//
//  ContentView-Total.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI

extension ContentView {
    struct Total: View {
        let amount: Double?, people: Int, tip: Double
        
        var body: some View {
            HStack(spacing: 0) {
                if amount != nil {
                    Column(title: "Total", amount: (total.amount, totalPerPerson.amount))
                    Column(title: "Tip", amount: (total.tip, totalPerPerson.tip))
                        .if(tip < 0.1) { $0.foregroundColor(.red) }
                        .if(tip > 0.2) { $0.foregroundColor(.green) }
                    Column(title: "Grand Total", amount: (total.grand, totalPerPerson.grand))
                }
            }
            .padding(.vertical, 10)
        }
        
        private var total: (amount: Double, tip: Double, grand: Double) {
            let amount = amount ?? 0
            let tip = amount * self.tip,
                grand = amount + tip
            
            return (amount, tip, grand)
        }
        
        private var totalPerPerson: (amount: Double, tip: Double, grand: Double) {
            let amount = total.amount / Double(people),
                tip = total.tip / Double(people),
                grand = total.grand / Double(people)
            
            return (amount, tip, grand)
        }
    }
}

//MARK: - Previews
struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.Total(amount: 10.2, people: 2, tip: 0)
    }
}
