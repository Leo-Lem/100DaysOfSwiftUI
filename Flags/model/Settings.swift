//
//  Settings.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

struct Settings: Codable {
    let countries: [Country]
    var rounds: Int, flags: Int
    
    var random: [Country] { random(flags) }
    func random(_ n: Int) -> [Country] { Array(countries.shuffled().prefix(n)) }
}
