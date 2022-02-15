//
//  previews.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

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

extension Game.Round {
    static var example: Self { Self(Int.random(in: 2...9)) }
}

extension Settings {
    static var example: Self { Settings(rounds: Int.random(in: 2...15), flags: Int.random(in: 2...9)) }
}

extension Country {
    static var example: Self { Country.allCases.randomElement() ?? .in }
}

typealias FlagImage = FlagsView.FlagImage
