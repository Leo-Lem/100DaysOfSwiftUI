//
//  HistoryView.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI
import MySwiftUI

struct HistoryView: View {
    let games: [Game]
    
    var body: some View {
        NavigationView {
            List(games) { game in
                VStack {
                    HStack {
                        Text("scored \(game.score)", font: .headline)
                        Spacer()
                        Text("\(game.timestamp.formatted())", font: .caption)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(game.rounds, id: \.self) { round in
                                VStack {
                                    ForEach(round.options, id: \.self) { country in
                                        FlagImage(country: country)
                                            .frame(maxHeight: 25)
                                            .overlay(round.correct(country) ? .green.opacity(0.8) : .gray.opacity(0.8))
                                            .clipShape(Capsule())
                                    }
                                    Text("\(round.score)", font: .headline)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Games")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(games: [.example, .example, .example])
    }
}
