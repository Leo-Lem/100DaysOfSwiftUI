//
//  previews.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

extension Game {
    static let example = `dynamic`
    static var dynamic: Game {
        var game = Game(settings: .example)
        for _ in 0..<Settings.example.rounds {
            game.round.options.forEach { country in game.try(country) }
            game.newRound()
        }
        return game
    }
}

extension Game.Round {
    static let example = Game.Round(3)
    static var dynamic: Self { Self(Int.random(in: 2...9)) }
}

extension Settings {
    static let example = Settings(rounds: 5, flags: 3)
    static var dynamic: Self { Settings(rounds: Int.random(in: 2...15), flags: Int.random(in: 2...9)) }
}

extension Country {
    static let example = Country.de
    static var dynamic: Self { Country.allCases.randomElement() ?? .in }
}

typealias FlagImage = FlagsView.FlagImage
