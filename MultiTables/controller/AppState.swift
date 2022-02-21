//
//  AppState.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation
import MyStorage

class AppState: ObservableObject {
    
    var settings: Settings {
        willSet { objectWillChange.send() }
        didSet { settings.save() }
    }
    
    var round: Round {
        willSet { objectWillChange.send() }
        didSet { round.save() }
    }
    
    var rounds: [Round] {
        willSet { objectWillChange.send() }
        didSet { rounds.save() }
    }
    
    init() {
        let settings: Settings = .load() ?? .default
        
        self.settings = settings
        self.round = .load() ?? Round(settings)
        self.rounds = .load() ?? []
    }
    
    func newRound() {
        if !round.answers.isEmpty { rounds.append(round) }
        self.round = Round(settings)
    }
    
}

fileprivate extension Settings {
    private static let key: String = "settings"
    func save() { UserDefaults.standard.setObject(self, forKey: Self.key) }
    static func load() -> Self? { UserDefaults.standard.getObject(forKey: key) }
}

fileprivate extension Round {
    private static let key: String = "round"
    func save() { UserDefaults.standard.setObject(self, forKey: Self.key) }
    static func load() -> Self? { UserDefaults.standard.getObject(forKey: key) }
}

fileprivate extension Array where Element == Round {
    private static let file: String = "rounds.json"
    func save() { try? FileManager.default.save(self, file: Self.file) }
    static func load() -> Self? { try? FileManager.default.load(file) }
}
