//
//  Country.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation
import MyStorage

struct Country: Identifiable {
    let id: String
    
    let name: (en: String, de: String)
}

extension Country: Hashable {
    static func == (lhs: Country, rhs: Country) -> Bool { lhs.id == rhs.id }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name.en)
        hasher.combine(name.de)
    }
}

extension Country: Codable {
    private enum CodingKeys: CodingKey { case alpha2, en, de }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.alpha2)
        let en: String = try container.decode(.en),
            de: String = try container.decode(.de)
        name = (en, de)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .alpha2)
        try container.encode(name.en, forKey: .en)
        try container.encode(name.de, forKey: .de)
    }
}

