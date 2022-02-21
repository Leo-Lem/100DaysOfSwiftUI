//
//  ReviewView.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MySwiftUI

struct ReviewView: View {
    let game: Game
    
    var body: some View {
        ForEach(Array(zip(game.questions, game.answers)), id: \.0) { (question, answer) in
            if let answer = answer {
                HStack {
                    Text(question.lhs, format: .number)
                    Text(question.op.symbol)
                    Text(question.rhs, format: .number)
                    Text("=")
                    Text(question.solution, format: .number)
                    
                    Spacer()
                    
                    if question.solution != answer {
                        Text("your answer was \(answer)", font: .caption.bold())
                    }
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(question.solution == answer ? .green: .red)
            }
        }
    }
}

//MARK: - Previews
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(game: .init(.default))
    }
}
