//
//  Game-Round.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation
import MyOthers

extension Game {
    struct Round: Hashable, Codable {
        let options: [Country], correct: Country
        private(set) var tries = [Country]()
        
        var score: Int { tried(correct) ? options.count - tries.count : 0 }
        
        init(_ options: [Country]) {
            self.options = options
            self.correct = options.randomElement()!
        }
    }
}

extension Game.Round {
    mutating func `try`(_ country: Country) {
        guard !tried(country), active else { return }
        tries.append(country)
    }
    
    func tried(_ country: Country) -> Bool { tries.contains(country) }
    func correct(_ country: Country) -> Bool { country == correct }
    //MARK: tried is encoded as the optional and the correct value is encoded as the boolean
    func triedAndCorrect(_ country: Country) -> Bool? { tried(country) ? correct(country) : nil }
    
    var active: Bool { score == 0 }
}
