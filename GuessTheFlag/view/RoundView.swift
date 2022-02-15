//
//  RoundView.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI

extension ContentView {
    struct RoundView: View {
        let round: Game.Round, tryCountry: (Country) -> Void, newRound: () -> Void
        
        var body: some View {
            VStack {
                VStack {
                    Text("Tap the flag of ", font: .subheadline.weight(.heavy))
                    Text(round.correct.rawValue, font: .largeTitle.weight(.semibold))
                }
                
                LazyVGrid(columns: cols) {
                    ForEach(round.options, id: \.self) { country in
                        FlagImage(country: country)
                            .onTapGesture {
                                tryCountry(country)
                                answer = country
                            }
                            .if(let: round.triedAndCorrect(country)) { view, correct in
                                view
                                    .overlay(correct ? .green.opacity(0.8) : .gray.opacity(0.5))
                                    .clipShape(Capsule())
                                    .disabled(true)
                            }
                            .if(let: answer) { view, answer in
                                view
                                    .alert("That's \(round.correct(answer) ? "correct!" : "wrong...")", item: $answer) { _ in
                                        Button("OK") {
                                            if round.correct(answer) { newRound() }
                                        }
                                    } message: { country in
                                        round.correct(country) ?
                                            Text("You scored \(round.score) point(s)!") :
                                            Text("It's the flag of \(country.rawValue).")
                                    }
                            }
                    }
                }
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        
        @State private var answer: Country? = nil
        
        private var cols: [GridItem] { Array(repeating: GridItem(), count: (round.options.count + 2) / 3) }
    }
}

struct RoundView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.RoundView(round: Game.Round.example, tryCountry: {_ in}, newRound: {})
    }
}
