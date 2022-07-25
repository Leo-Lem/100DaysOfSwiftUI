//
//  ContentView-Total.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI
import MySwiftUI
import MyNumbers

extension WeSplitForm {
    struct Total: View {
        
        let entry: Entry
        
        var body: some View {
            HStack {
                ForEach(columns, id: \.0) { column in
                    Menu {
                        Text("\(column.amount.formatted(.currency(code: currencyCode))) altogether.", font: .headline)
                    } label: {
                        VStack {
                            Text(column.title, font: .caption.bold(), color: .secondary)
                            Text(column.amount / people, format: .currency(code: currencyCode), font: .headline)
                        }
                        .if(column.title.contains("Tip") && tip < 0.1) { $0.foregroundColor(.red) }
                        .if(column.title.contains("Tip") && tip > 0.2) { $0.foregroundColor(.blue) }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        
        private var amount: Double { entry.total }
        private var people: Int { entry.people }
        private var tip: Double { entry.tip }
        
        private var columns: [(title: String, amount: Double)] {
            [
                ("Amount/Person", amount),
                ("Tip/Person", amount * tip),
                ("Total/Person", amount * (1 + tip))
            ]
        }
        private var currencyCode: String { Locale.current.currencyCode ?? "USD" }
    }
}

// MARK: - (Previews)
struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitForm.Total(entry: .example)
    }
}
