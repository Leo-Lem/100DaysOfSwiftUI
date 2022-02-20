//
//  Settings.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation

struct Settings: Codable {
    var table: Int,
        questions: Int,
        operation: Self.Operation
    
    var maxQuestions: Int { table.triangular }
    
    static let `default` = Settings(table: 10, questions: 10, operation: .add)
}
