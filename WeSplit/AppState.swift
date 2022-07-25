//
//  AppState.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import Foundation
import MyData

class AppState: ObservableObject {
    
    var history: [Entry] = [] {
        willSet { objectWillChange.send() }
        didSet { history.save() }
    }
    
    init() { history.load() }
    
}

extension AppState {
    
    func addEntry(_ wip: Entry.WIP) {
        if let entry = Entry(wip) {
            history.append(entry)
        } else {
            print("Warning: Entry couldn't be saved, as there is no total available.")
        }
    }
    
}

extension AppState {
    
    static var currencyCode: String { Locale.current.currencyCode ?? "USD" }
    
}

// MARK: - (persistence methods)
fileprivate extension Array where Element == Entry {
    
    private var file: URL { FileManager.documentsDirectory.appendingPathComponent("entries.json") }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: file)
        } catch { print("saving entries failed: \(error)") }
    }
    
    mutating func load() {
        do {
            let data = try Data(contentsOf: file),
                decoded: [Entry] = try JSONDecoder().decode(data)
            self = decoded
        } catch { print("loading entries failed: \(error)") }
    }
    
}
