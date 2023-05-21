//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Leopold Lemmermann on 17.02.22.
//

import SwiftUI
import MySwiftUI
import MyOthers

struct ContentView: View {
    var body: some View {
        Form {
            Section("Your move") {
                Picker("Move", selection: $move, items: Move.allCases, id: \.self) { Text($0.name) }
                    .pickerStyle(.segmented)
                
                Picker("Bet", selection: $bet, items: Outcome.allCases, id: \.self) { Text($0.name) }
                    .pickerStyle(.segmented)
                
                Button("Play", action: play)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            
            Section("Rounds") {
                ForEach(rounds, id: \.0) { round in
                    HStack {
                        Text(round.id, format: .number, font: .title.bold())
                        Divider()
                        VStack {
                            Text(round.outcome == round.bet ? "You Win! " : "App Wins... ", font: .headline)
                            + Text("(Your bet: \(round.bet.name))", font: .headline)
                            Text(Outcome.phrase(round.move, round.app), font: .subheadline, color: .secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .alert("Game!", isPresented: $alert, actions: { Button("New Game", action: reset) }, message: { Text("You scored \(score)!") })
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) { if round < 8 { Text("Round \(round + 1)") } }
        }
        .group { $0
            .navigationTitle("Rock, Paper, Scissors")
            .embedInNavigation()
            .navigationViewStyle(.stack)
        }
    }
    
    @State private var bet: Outcome = .win
    @State private var move: Move = .rock
    
    @State private var app: Move = .rock
    @State private var outcome: Outcome? = nil
    
    @State private var round: Int = 0
    @State private var rounds = [(id: Int, move: Move, app: Move, bet: Outcome, outcome: Outcome)]()
    @State private var alert: Bool = false
    
    private var score: Int {
        rounds.reduce(0) { $0 + ($1.outcome == $1.bet ? 1 : -1) }
    }
    
    private func play() {
        guard round < 8 else {
            return alert = true
        }
        
        app = .random
        outcome = .init(move, app)
        
        rounds.append((round + 1, move, app, bet, outcome!))
        round += 1
    }
    
    private func reset() {
        self.bet = .win
        self.move = .rock
        
        self.outcome = nil
        
        self.round = 0
        self.rounds = []
    }
}

extension Move {
    var name: String {
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        }
    }
    
    static var random: Move { Self.allCases.randomElement() ?? .rock }
}

extension Outcome {
    var name: String {
        switch self {
        case .win: return "Win"
        case .lose: return "Lose"
        case .draw: return "Draw"
        }
    }
    
    init(_ main: Move, _ other: Move) {
        if main < other {
            self = .lose
        } else if main > other {
            self = .win
        } else {
            self = .draw
        }
    }
    
    static func phrase(_ main: Move, _ other: Move) -> String {
        switch main {
        case other: return "Draw: \(main.name)!"
        case ...other: return "App's \(other) beats your \(main)!"
        case other...: return "Your \(main) beats app's \(other)!"
        default: return ""
        }
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
