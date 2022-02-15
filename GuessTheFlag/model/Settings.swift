//
//  Game-Settings.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

struct Settings: Codable {
    var rounds: Int, flags: Int
}

#if DEBUG
extension Settings {
    static var example: Self { Settings(rounds: Int.random(in: 2...20), flags: Int.random(in: 2...9)) }
}
#endif
