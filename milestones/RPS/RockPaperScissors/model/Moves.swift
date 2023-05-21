//
//  Moves.swift
//  RockPaperScissors
//
//  Created by Leopold Lemmermann on 17.02.22.
//

import Foundation

enum Move: CaseIterable {
    case rock, paper, scissors
}

extension Move: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): return true
        default: return false
        }
    }
}
