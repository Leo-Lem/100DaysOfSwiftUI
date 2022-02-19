//
//  GameController.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation
import MyOthers
import MyStorage

class AppState: ObservableObject {
    
    let countries: [Country] = .load()
    
    var game: Game = .load() {
        willSet { objectWillChange.send() }
        didSet { game.save() }
    }
    
    var settings: Settings = .load() {
        willSet { objectWillChange.send() }
        didSet { settings.save() }
    }
    
    var games: [Game] = .load() {
        willSet { objectWillChange.send() }
        didSet { games.save() }
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
fileprivate extension Game {
    
    private static let key = "game"
    func save() { UserDefaults.standard.setObject(self, forKey: Self.key) }
    static func load() -> Self { UserDefaults.standard.getObject(forKey: key) ?? Game(settings: .load()) }
    
}

fileprivate extension Settings {
    
    private static let key = "settings"
    func save() { UserDefaults.standard.setObject(self, forKey: Self.key) }
    static func load() -> Self { UserDefaults.standard.getObject(forKey: key) ?? Settings(countries: .load(), rounds: 5, flags: 3) }
    
}

fileprivate extension Array where Element == Country {
    
    private static let file = "countries.json"
    
    static func load() -> Self {
        do {
            return try Bundle.main.load(file)
        } catch { fatalError("Couldn't load countries: \(error)") }
    }
    
}

fileprivate extension Array where Element == Game {
    
    private static let file = FileManager.documentsDirectory.appendingPathComponent("games.json")
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: Self.file)
        } catch { print("saving games failes: \(error)") }
    }
    
    static func load() -> Self {
        do {
            let data = try Data(contentsOf: file),
                decoded: [Game] = try JSONDecoder().decode(data)
            return decoded
        } catch {
            print("loading games failes: \(error)")
            return []
        }
    }
    
}
