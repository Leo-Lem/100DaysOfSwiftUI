//
//  ContentView-Total.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI
import MySwiftUI
import MyOthers

extension ContentView {
    struct Total: View {
        let amount: Double, people: Int, tip: Double
        
        var body: some View {
            HStack {
                ForEach(columns, id: \.0) { column in
                    Menu {
                        Text("\(column.amount.formatted(.currency(code: currencyCode))) altogether.", font: .headline)
                    } label: {
                        VStack {
                            Text(column.title, font: .caption.bold(), color: .secondary)
                            Text(column.perPerson, format: .currency(code: currencyCode), font: .headline)
                        }
                        .if(column.title == "Tip" && tip < 0.1) { $0.foregroundColor(.red) }
                        .if(column.title == "Tip" && tip > 0.2) { $0.foregroundColor(.green) }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        
        private var columns: [(title: String, amount: Double, perPerson: Double)] {
            [
                ("Amount/Person", amount, amount / people),
                ("Tip/Person", amount * tip, amount * tip / people),
                ("Total/Person", amount * (1 + tip), amount * (1 + tip) / people)
            ]
        }
        private var currencyCode: String { Locale.current.currencyCode ?? "USD" }
    }
}

//MARK: - Previews
struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.Total(amount: 10.2, people: 2, tip: 0)
    }
}
