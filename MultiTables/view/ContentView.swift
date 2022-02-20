//
//  ContentView.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Section("Up to \(round.settings.table) \(round.settings.operation.rawValue) \(round.settings.table)") {
                Text("What is \(round.current.lhs) \(round.current.op.rawValue) \(round.current.rhs)?", font: .headline)
                
                TextField("e.g. 25", value: $answer, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .onSubmit(submit)
                    .focused($focus)
            }
            .frame(maxWidth: .infinity)
            .alert("\(round.score) out of \(round.questions.count)", isPresented: $alert) {
                Button("Review") { alert = false }
                Button("New Round", action: new)
            }
            
            if !state.round.answers.isEmpty { Section("Review") { ReviewView(round: round) } }
        }
        .sheet(isPresented: $menu) { MenuView(settings: $state.settings, newGame: new) }
        .sheet(isPresented: $history) { HistoryView(rounds: state.rounds) }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(systemImage: "gear.circle", true: $menu)
                Button(systemImage: "list.bullet.circle", true: $history)
            }
            
            ToolbarItem(placement: .destructiveAction) {
                Button("New Round", action: state.newRound)
            }
            
            ToolbarItem(placement: .keyboard) {
                Button("Submit", action: submit)
                    .disabled(self.answer == nil)
            }
            
            ToolbarItem(placement: .bottomBar) {
                ProgressView(
                    "Question \(round.index + 1) of \(round.questions.count)",
                    value: Double(round.index),
                    total: Double(round.questions.count)
                )
            }
        }
        .group { $0
            .navigationTitle("Tables")
            .embedInNavigation()
            .navigationViewStyle(.stack)
        }
    }
    
    @State private var answer: Int?
    @StateObject private var state = AppState()
    
    @State private var menu = false
    @State private var history = false
    @State private var alert = false
    @FocusState private var focus: Bool
}

private extension ContentView {
    var settings: Settings { state.settings }
    var round: Round { state.round }
    
    func submit() {
        guard let answer = answer else { return }
        state.round.submit(answer)
        
        self.answer = nil
        self.focus = false
        
        guard state.round.active else { return alert = true }
    }
    
    func new() {
        state.newRound()
        self.menu = false
        self.answer = nil
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
