//
//  Mission-Display.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import SwiftUI

extension Mission {
    
    var formattedName: String { "Apollo \(id)" }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrewNames: String {
        crew.reduce("") { names, member in "\(names), \(member.id)" }
            .dropFirst(2)
            .capitalized
    }
    
    var image: Image { Image("apollo\(id)") }
    
}

extension CrewMember.Role {
    
    var formattedRole: String { self.rawValue }
    
}
