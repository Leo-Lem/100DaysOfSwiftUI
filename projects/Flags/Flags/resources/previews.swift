//
//  previews.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

extension Game {
    static let example: Game = {
        var game = Game(settings: .example)
        for _ in 0..<Settings.example.rounds {
            game.round.options.forEach { country in game.try(country) }
            game.newRound()
        }
        return game
    }()
}

extension Game.Round { static let example = Game.Round([.example, .init(id: "fr", name: ("France", "Frankreich"))]) }
extension Settings { static let example = Settings(countries: [.example, .init(id: "fr", name: ("France", "Frankreich"))], rounds: 5, flags: 3) }
extension Country { static let example = Country(id: "de", name: ("Germany", "Deutschland")) }
typealias FlagImage = FlagsView.FlagImage
