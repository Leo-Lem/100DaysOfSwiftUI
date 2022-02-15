//
//  FlagsView-Round.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import SwiftUI
import MySwiftUI

extension FlagsView {
    struct Round: View {
        let round: Game.Round, tryCountry: (Country) -> Void, newRound: () -> Void
        
        var body: some View {
            VStack {
                VStack {
                    Text(~.tapFlagLabel, font: .subheadline.weight(.heavy))
                    Text(round.correct.localized, font: .largeTitle.weight(.semibold))
                }
                .minimumScaleFactor(0.5)
                .lineLimit(0)
                
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
                                    .contextMenu { Text("\(country.localized)") }
                            }
                            .alert(~.answerAlertTitle(correct: round.correct(answer ?? .de)), item: $answer) { answer in
                                Button(~.okButton) {
                                    if round.correct(answer) { newRound() }
                                }
                            } message: { answer in
                                Text(~.answerAlertMessage(correct: round.correct(answer), score: round.score, country: answer.localized))
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

//MARK: - Previews
struct RoundView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView.Round(round: Game.Round.example, tryCountry: {_ in}, newRound: {})
    }
}
