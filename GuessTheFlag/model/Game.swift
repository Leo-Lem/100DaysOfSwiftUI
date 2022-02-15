//
//  Game.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import Foundation

struct Game: Identifiable, Codable {
    var id = UUID(), timestamp = Date()
    
    private let settings: Settings
    private(set) var round: Round, rounds = [Round]()
    
    init(settings: Settings) {
        self.settings = settings
        self.round = Round(settings.flags)
    }
}

extension Game {
    mutating func `try`(_ country: Country) {
        guard round.active else { return }
        round.try(country)
    }
    
    mutating func newRound() {
        rounds.append(round)
        guard active else { return }
        self.round = Round(settings.flags)
    }
    
    var score: Int { rounds.reduce(0) { $0 + $1.score } }
    var active: Bool { rounds.count < settings.rounds }
}

#if DEBUG
extension Game {
    static var example: Game {
        var game = Game(settings: .example)
        for _ in 0..<Settings.example.rounds {
            game.round.options.forEach { country in game.try(country) }
            game.newRound()
        }
        return game
    }
}
#endif
