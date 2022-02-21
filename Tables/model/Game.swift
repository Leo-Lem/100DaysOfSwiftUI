//
//  Game.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation
import MyNumbers
import MyCollections

struct Game: Identifiable, Codable {
    
    let id: UUID,
        timestamp: Date,
        settings: Settings
    let questions: [Question]
    private(set) var active = true,
                     index = 0,
                     answers = [Int]()
    
    init(_ settings: Settings) {
        self.id = UUID()
        self.timestamp = Date()
        self.settings = settings
        
        self.questions = .questions(settings)
    }
    
}

extension Game {
    
    var current: Question { questions[index] }
    var score: Int { answers.enumerated().reduce(0, { $0 + (($1.element == questions[$1.offset].solution) ? 1 : 0) }) }
    var maxScore: Int { answers.count }
    
}

extension Game {
    
    mutating func submit(_ answer: Int) {
        answers.append(answer)
        
        index == questions.lastIndex ? (active = false) : index++
    }
    
}
