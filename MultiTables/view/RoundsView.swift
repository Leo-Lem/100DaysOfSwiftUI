//
//  HistoryView.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MySwiftUI

struct HistoryView: View {
    let rounds: [Round]
    
    var body: some View {
        List(rounds) { round in
            VStack {
                HStack {
                    Text("scored \(round.score)", font: .headline)
                    Spacer()
                    Text(round.timestamp, format: .dateTime, font: .caption.bold())
                }
                .padding()
                
                ReviewView(round: round)
            }
        }
        .navigationTitle("Rounds")
        .embedInNavigation()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(rounds: [.init(.default)])
    }
}
