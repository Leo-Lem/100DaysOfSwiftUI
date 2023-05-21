//
//  GameView.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MySwiftUI

struct GameView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        //TODO: Redesign this to make it look nicer
        List {
            if game.active {
                Section("What is \(game.current.lhs) \(game.current.op.symbol) \(game.current.rhs)?") {
                    TextField("Type in your answer", value: $answer, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .onSubmit(submit)
                        .focused($focus)
                }
            }
            
            if !game.answers.isEmpty {
                Section("Review") { ReviewView(game: game) }
            }
        }
        .confirmationDialog("Game!", isPresented: $alert, titleVisibility: .visible) {
            Button("New Game", action: newGame)
            Button("Change Settings") { state.screen = .settings }
            Button("Return To Menu") { state.screen = .menu }
        } message: {
            Text("You scored \(game.score) out of \(game.questions.count).")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("up to \(game.settings.table) \(game.settings.operation.symbol) \(game.settings.table)", font: .subheadline)
            }
            
            ToolbarItem(placement: .keyboard) {
                Button("Submit", action: submit)
                    .disabled(self.answer == nil)
            }
            
            ToolbarItem(placement: .bottomBar) {
                if game.active {
                ProgressView(
                    "Question \(game.index + 1) of \(game.questions.count)",
                    value: Double(game.index + 1),
                    total: Double(game.questions.count)
                )
                } else {
                    Text("You scored \(game.score) out of \(game.maxScore)!", font: .headline)
                }
            }
        }
    }
    
    @State private var answer: Int?
    @State private var alert = false
    @FocusState private var focus: Bool
}

private extension GameView {
    var game: Game { state.game ?? .init(.default) }
    
    func submit() {
        guard let answer = answer else { return }
        state.submitAnswer(answer)
        
        self.answer = nil
        self.focus = false
        
        if !game.active { alert = true }
    }
    
    func newGame() {
        self.answer = nil
        state.newGame()
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(AppState())
            .embedInNavigation()
    }
}
