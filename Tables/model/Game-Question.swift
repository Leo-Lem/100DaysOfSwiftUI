//
//  Game-Question.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

extension Game {
    struct Question: Codable, Hashable {
        
        let lhs: Int,
            rhs: Int,
            op: Settings.Operation
        
        var solution: Int { op.operate(lhs, rhs) }
        
        func check(_ solution: Int) -> Bool { solution == self.solution }
        
    }
}

extension Array where Element == Game.Question {
    init(_ table: Int, operation: Settings.Operation) {
        self.init()
        
        for lhs in 1...table {
            for rhs in 1...lhs {
                self.append(Element(lhs: lhs, rhs: rhs, op: operation))
            }
        }
    }
    
    static func questions(_ settings: Settings) -> Self {
        let all = [Element](settings.table, operation: settings.operation),
            shuffled = all.shuffled(),
            questions = Array(shuffled.prefix(settings.questions))
                              
        return questions
    }
}
