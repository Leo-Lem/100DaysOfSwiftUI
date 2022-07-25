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
    
    init(total: Double, people: Int, tip: Double) {
        id = UUID()
        timestamp = .now
        self.total = total
        self.people = people
        self.tip = tip
    }
    
}

extension Entry {
    
    init?(_ wip: Entry.WIP) {
        guard let wipTotal = wip.total else { return nil }
        
        id = UUID()
        timestamp = .now
        total = wipTotal
        people = wip.people
        tip = wip.tip
    }
    
}
