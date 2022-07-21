//
//  ContentView-History.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI

extension ContentView {
    struct History: View {
        let entries: [Entry]
        
        var body: some View {
            if entries.isEmpty { Text("Nothing to see here") }
            
            List(entries.reversed()) { entry in
                VStack(alignment: .leading) {
                    Text(entry.timestamp, format: .dateTime, font: .caption.bold())
                    Total(amount: entry.total, people: entry.people, tip: entry.tip)
                        .contextMenu { Text(entry.timestamp.formatted(date: .long, time: .shortened)) }
                }
            }
        }
    }
}

#if DEBUG
//MARK: - Previews
struct History_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.History(entries: [.example, .example])
    }
}

extension Entry {
    static let example = Entry(total: 10, people: 6, tip: 0.4)
}

typealias Total = ContentView.Total
#endif
