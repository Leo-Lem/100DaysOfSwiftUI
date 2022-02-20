//
//  Round-Question.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

extension Round {
    struct Question: Codable, Hashable {
        let lhs: Int, rhs: Int, op: Settings.Operation
        
        var solution: Int { op.operate(lhs, rhs) }
        
        func check(_ solution: Int) -> Bool { solution == self.solution }
    }
}

extension Array where Element == Round.Question {
    init(_ table: Int, operation: Settings.Operation) {
        self.init()
        
        for lhs in 1...table {
            for rhs in 1...lhs {
                self.append(Element(lhs: lhs, rhs: rhs, op: operation))
            }
        }
    }
}
