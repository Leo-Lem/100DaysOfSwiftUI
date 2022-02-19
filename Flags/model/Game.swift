//
//  Game.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

struct Game: Identifiable, Codable {
    var id = UUID(), timestamp = Date()
    
    private let settings: Settings
    private(set) var round: Round, rounds = [Round]()
    
    init(settings: Settings) {
        self.settings = settings
        self.round = Round(settings.random)
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
        self.round = Round(settings.random)
    }
    
    var score: Int { rounds.reduce(0) { $0 + $1.score } }
    var active: Bool { rounds.count < settings.rounds }
}
