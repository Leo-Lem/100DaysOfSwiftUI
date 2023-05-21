//
//  Mission.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 19.08.21.
//

import Foundation
import MyData

struct Mission: Identifiable {
    
    let id: Int,
        launchDate: Date?,
        crew: [CrewMember],
        description: String
    
}

extension Mission: Decodable {
    
    enum CodingKeys: CodingKey {
        case id, launchDate, crew, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(.id)
        self.crew = try container.decode(.crew)
        self.description = try container.decode(.description)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        let dateString: String? = try container.decodeIfPresent(.launchDate)
        if let dateString = dateString {
            self.launchDate = formatter.date(from: dateString)
        } else {
            self.launchDate = nil
        }
    }
    
}

extension Array where Element == Mission {
    
    func getMissionsFor(astronaut: Astronaut) -> [Mission] {
        self.filter { mission in
            mission.crew.contains { member in
                member.id == astronaut.id
            }
        }
    }
    
}

extension Mission {
    
    func getRoleOf(astronaut: Astronaut) -> CrewMember.Role? {
        self.crew.getCrewMemberFor(id: astronaut.id)?.role
    }
    
    func getRoleFor(id: String) -> CrewMember.Role? {
        self.crew.getCrewMemberFor(id: id)?.role
    }
    
}
