//
//  Settings.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

struct Settings: Codable {
    var table: Int {
        didSet { self.questions = min(questions, maxQuestions) }
    }
        
    var questions: Int,
        operation: Self.Operation
    
    var maxQuestions: Int { table.triangular }
    
    static let `default` = Settings(table: 10, questions: 5, operation: .mul)
}
