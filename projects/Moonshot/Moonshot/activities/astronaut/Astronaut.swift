//
//  Astronaut.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 19.08.21.
//

import Foundation

struct Astronaut: Decodable, Identifiable {
    
    let id: String,
        name: String,
        description: String
    
}

extension Array where Element == Astronaut {
    
    func getAstronautFor(id: String) -> Astronaut? {
        self.first { astronaut in astronaut.id == id }
    }
    
}

extension Astronaut {
    
    func isCommanderOf(mission: Mission) -> Bool {
        mission.getRoleOf(astronaut: self) == .commander
    }
    
}
