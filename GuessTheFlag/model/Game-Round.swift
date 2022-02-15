//
//  Round.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import Foundation
import MyOthers

extension Game {
    struct Round: Hashable, Codable {
        let options: [Country], correct: Country
        private(set) var tries = [Country]()
        
        var score: Int { tried(correct) ? options.count - tries.count : 0 }
        
        init(_ flags: Int) {
            let options = Country.random(flags)
            
            self.options = options
            self.correct = options.randomElement() ?? .example
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

#if DEBUG
extension Game.Round {
    static var example: Self { Self(Int.random(in: 2...9)) }
}
#endif
