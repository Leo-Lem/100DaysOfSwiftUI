//
//  TotalView.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI

extension ContentView {
    struct TotalView: View {
        let amount: Double?, people: Int, tip: Double
        
        var body: some View {
            Group {
                if amount != nil {
                    VStack {
                        HStack {
                            Text("Total").frame(maxWidth: .infinity)
                            Text("Tip").frame(maxWidth: .infinity)
                            Text("Grand Total").frame(maxWidth: .infinity)
                        }
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                        
                        HStack {
                            Text(total.amount, format: .currency(code: currencyCode)).frame(maxWidth: .infinity)
                            Text(total.tip, format: .currency(code: currencyCode)).frame(maxWidth: .infinity)
                            Text(total.grand, format: .currency(code: currencyCode)).frame(maxWidth: .infinity)
                        }
                        .font(.headline)
                        
                        Divider()
                        
                        HStack {
                            Text(totalPerPerson.amount, format: .currency(code: currencyCode)).frame(maxWidth: .infinity)
                            Text(totalPerPerson.tip, format: .currency(code: currencyCode)).frame(maxWidth: .infinity)
                            Text(totalPerPerson.grand, format: .currency(code: currencyCode)).frame(maxWidth: .infinity)
                        }
                        .font(.headline)
                        
                        HStack {
                            Text("per person", font: .caption.bold(), color: .secondary).frame(maxWidth: .infinity)
                            Text("per person", font: .caption.bold(), color: .secondary).frame(maxWidth: .infinity)
                            Text("per person", font: .caption.bold(), color: .secondary).frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical, 10)
                    .background(.bar)
                }
            }
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
        
        private let currencyCode = Locale.current.currencyCode ?? "USD"
    }
}

//MARK: - Previews
struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.TotalView(amount: 10.2, people: 2, tip: 0.2)
    }
}
