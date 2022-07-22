//
//  CrewMember.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import Foundation

struct CrewMember {
    
    let id: String,
        role: Role
    
}

extension CrewMember: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "name", role
    }
    
}

extension Array where Element == CrewMember {
    
    func getCrewMemberFor(id: String) -> CrewMember? {
        self.first { crewMember in crewMember.id == id }
    }
    
}
