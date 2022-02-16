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
            List(entries) { entry in
                VStack {
                    Divider()
                    Total(amount: entry.total, people: entry.people, tip: entry.tip)
                        .background {
                            Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened), font: .largeTitle.bold())
                                .opacity(0.08)
                                .rotationEffect(.degrees(-15))
                                .multilineTextAlignment(.center)
                                .contextMenu {
                                    Text(entry.timestamp.formatted(date: .long, time: .shortened))
                                }
                        }
                    Divider()
                }
            }
        }
    }
}
typealias Total = ContentView.Total
//MARK: - Previews
struct History_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.History(entries: [.example, .example])
    }
}

extension Entry {
    static let example = Entry(total: 10, people: 6, tip: 0.4)
}
