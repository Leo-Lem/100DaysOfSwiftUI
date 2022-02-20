//
//  Round.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation
import MyNumbers
import MyCollections

struct Round: Identifiable, Codable {
    
    let id: UUID, timestamp: Date, settings: Settings
    let questions: [Question]
    private(set) var active = true, index = 0, answers = [Int]()
    
    init(_ settings: Settings) {
        self.id = UUID()
        self.timestamp = Date()
        self.settings = settings
        
        self.questions = .questions(settings)
    }
    
}

extension Round {
    
    var current: Question { questions[index] }
    var score: Int { answers.enumerated().reduce(0, { $0 + (($1.element == questions[$1.offset].solution) ? 1 : 0) }) }
    
}

extension Round {
    
    mutating func submit(_ answer: Int) {
        answers.insert(answer, at: index)
        nextQuestion()
    }
    
    private mutating func nextQuestion() {
        guard index < questions.lastIndex else { return active = false }
        index++
    }
    
}

extension Array where Element == Round.Question {
    static func questions(_ settings: Settings) -> Self {
        let all = [Element](settings.table, operation: settings.operation),
            shuffled = all.shuffled(),
            questions = Array(shuffled.prefix(settings.questions))
                              
        return questions
    }
}
