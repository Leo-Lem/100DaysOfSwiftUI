//
//  ContentView-History.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI

extension WeSplitForm {
    struct History: View {
        let entries: [Entry]
        
        var body: some View {
            if entries.isEmpty { Text("Nothing to see here") }
            
            List(entries.reversed()) { entry in
                VStack(alignment: .leading) {
                    Text(entry.timestamp, format: .dateTime, font: .caption.bold())
                    Total(entry: entry)
                        .contextMenu { Text(entry.timestamp.formatted(date: .long, time: .shortened)) }
                }
            }
        }
    }
}

#if DEBUG
// MARK: - (Previews)
struct History_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitForm.History(entries: [.example, .example])
    }
}

typealias Total = WeSplitForm.Total
#endif
