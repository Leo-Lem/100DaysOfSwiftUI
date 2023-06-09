//
//  FlagsView-History.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import SwiftUI
import MySwiftUI

extension FlagsView {
    struct History: View {
        let games: [Game]
        
        var body: some View {
            NavigationView {
                ScrollView {
                    ForEach(games) { game in
                        VStack {
                            HStack {
                                Text(~.scoreLabel(game.score), font: .headline)
                                Spacer()
                                Text(game.timestamp.formatted(), font: .caption)
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
                                                    .contextMenu { Text("\(country.localized)") }
                                            }
                                            
                                            Text(round.score.formatted(), font: .headline)
                                        }
                                    }
                                }
                            }
                        }
                        
                        Divider()
                    }
                    .padding()
                }
                .navigationTitle(~.historyLabel)
            }
        }
    }
}

//MARK: - Previews
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView.History(games: [.example, .example])
    }
}
