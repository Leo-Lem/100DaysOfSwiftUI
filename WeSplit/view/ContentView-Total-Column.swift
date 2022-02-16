//
//  ContentView-Total-Column.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI

extension ContentView.Total {
    struct Column: View {
        let title: String, amount: (total: Double, person: Double)
        
        var body: some View {
            VStack {
                Text(title, font: .caption.bold(), color: .secondary)
                Text(amount.total, format: .currency(code: currencyCode), font: .headline)
                Divider()
                Text(amount.person, format: .currency(code: currencyCode), font: .headline)
                Text("per person", font: .caption.bold(), color: .secondary)
            }
        }
        
        private let currencyCode = Locale.current.currencyCode ?? "USD"
    }
}

//MARK: - Previews
struct Column_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.Total.Column(title: "Total", amount: (10.0, 5.0))
    }
}
