//
//  CrewMember-Role.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import Foundation

extension CrewMember {
    
    enum Role: String {
        case commander = "Commander",
             commandModulePilot = "Command Module Pilot",
             lunarModulePilot = "Lunar Module Pilot",
             commandPilot = "Command Pilot",
             seniorPilot = "Senior Pilot",
             pilot = "Pilot"
    }
    
}

extension CrewMember.Role: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        
        if let role = Self(rawValue: raw.capitalized) {
            self = role
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot initialize CrewMember.Role from invalid String value \(raw)"
            )
        }
    }
    
}
