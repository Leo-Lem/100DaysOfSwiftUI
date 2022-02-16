//
//  AppState.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import Foundation
import MyStorage

class AppState: ObservableObject {
    
    var history: [Entry] = [] {
        willSet { objectWillChange.send() }
        didSet { history.save() }
    }
    
    init() { history.load() }
    
}

extension AppState {
    
    func saveEntry(total: Double, people: Int, tip: Double) {
        history.append(Entry(total: total, people: people, tip: tip))
    }
    
}


//MARK: - persistence methods
fileprivate extension Array where Element == Entry {
    
    private var file: URL { FileManager.documentsDirectory.appendingPathComponent("entries.json") }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: file)
        } catch { print("saving entries failes: \(error)") }
    }
    
    mutating func load() {
        do {
            let data = try Data(contentsOf: file),
                decoded: [Entry] = try JSONDecoder().decode(data)
            self = decoded
        } catch { print("loading entries failes: \(error)") }
    }
    
}
