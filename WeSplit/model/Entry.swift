//
//  Entry.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import Foundation

struct Entry: Identifiable, Codable {
    
    let id: UUID,
        timestamp: Date
    
    let total: Double,
        people: Int,
        tip: Double
    
}

extension Entry {
    
    init(total: Double, people: Int, tip: Double) {
        self.init(
            id: UUID(),
            timestamp: Date(),
            total: total,
            people: people,
            tip: tip
        )
    }
    
}
