//
//  Country.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import Foundation

enum Country: String, CaseIterable, Equatable, Codable {
    case estonia = "Estonia",
         france = "France",
         germany = "Germany",
         ireland = "Ireland",
         italy = "Italy",
         nigeria = "Nigeria",
         poland = "Poland",
         russia = "Russia",
         spain = "Spain",
         uk = "UK",
         us = "US"
    
    static func random(_ n: Int) -> [Country] { Array(allCases.shuffled().prefix(n)) }
}

#if DEBUG
extension Country {
    static var example: Self { Country.allCases.randomElement() ?? .nigeria }
}
#endif
