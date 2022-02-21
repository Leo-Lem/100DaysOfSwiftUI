//
//  AppState.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation
import MyStorage

class AppState: ObservableObject {
    
    @Published var screen: Screen = .menu
    
    var settings: Settings {
        willSet { objectWillChange.send() }
        didSet { settings.save() }
    }
    
    var game: Game? {
        willSet { objectWillChange.send() }
        didSet { game?.save() }
    }
    
    var history: [Game] {
        willSet { objectWillChange.send() }
        didSet { history.save() }
    }
    
    init() {
        let settings: Settings = .load() ?? .default
        
        self.settings = settings
        self.history = .load() ?? []
        self.game = .load()
    }
    
}

extension AppState {
    
    enum Screen { case menu,
                       game,
                       settings,
                       history
    }
    
}

extension AppState {
    
    func newGame() {
        if let game = game, !game.answers.isEmpty { history.append(game) }
        self.game = Game(settings)
    }
    
    func submitAnswer(_ answer: Int) {
        game?.submit(answer)
    }
    
}

fileprivate extension Settings {
    private static let key: String = "settings"
    func save() { UserDefaults.standard.setObject(self, forKey: Self.key) }
    static func load() -> Self? { UserDefaults.standard.getObject(forKey: key) }
}

fileprivate extension Game {
    private static let key: String = "round"
    func save() { UserDefaults.standard.setObject(self, forKey: Self.key) }
    static func load() -> Self? { UserDefaults.standard.getObject(forKey: key) }
}

fileprivate extension Array where Element == Game {
    private static let file: String = "rounds.json"
    func save() { try? FileManager.default.save(self, file: Self.file) }
    static func load() -> Self? { try? FileManager.default.load(file) }
}
