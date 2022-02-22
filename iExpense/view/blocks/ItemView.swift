//
//  ItemView.swift
//  iExpense
//
//  Created by Leopold Lemmermann on 22.02.22.
//

import SwiftUI
import MySwiftUI

struct ItemView: View {
    let item: Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name, font: .headline)
                Text(item.kind.specificLabel)
            }
            
            Spacer()
            
            Text(item.formattedAmount, font: .headline, color: item.amountColor)
        }
        .accessibilityElement()
        .accessibilityLabel("\(item.name), a \(item.kind.specificLabel) (\(item.kind.label)) amounting to \(item.amount)$")
    }
}

#if DEBUG
//MARK: - Previews
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: .example)
    }
}

extension Item {
    static let example = Item("Groceries", kind: .expense(.living), amount: 34.26)
}
#endif
