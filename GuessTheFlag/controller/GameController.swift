//
//  GameController.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import Foundation
import MyOthers
import MyStorage

class AppState: ObservableObject {
    
    @Published var game = Game(settings: .example)
    var games = [Game]() {
        willSet { objectWillChange.send() }
        didSet { games.save() }
    }
    var settings: Settings = .example {
        willSet { objectWillChange.send() }
        didSet { settings.save() }
    }
    
    init() {
        games.load()
        settings.load()
        self.game = Game(settings: settings)
    }
    
}

extension AppState {
    
    func `try`(_ country: Country) { game.try(country) }
    func newRound() { game.newRound() }
    func newGame(save: Bool = true) {
        if save { self.games.append(game) }
        self.game = Game(settings: settings)
    }
    
}

//MARK: - persistence methods
fileprivate extension Array where Element == Game {
    
    private var file: URL { FileManager.documentsDirectory.appendingPathComponent("games.json") }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: file)
        } catch { print("saving games failes: \(error)") }
    }
    
    mutating func load() {
        do {
            let data = try Data(contentsOf: file),
                decoded = try JSONDecoder().decode([Game].self, from: data)
            self = decoded
        } catch { print("loading games failes: \(error)") }
    }
    
}

fileprivate extension Settings {
    
    private var key: String { "settings" }
    func save() { UserDefaults.standard.setObject(self, forKey: key) }
    mutating func load() { self = UserDefaults.standard.getObject(forKey: key, castTo: Self.self) ?? Settings(rounds: 5, flags: 3) }
    
}
