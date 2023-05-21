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
        do {
            try toAddEntry(wip)
        } catch {
            print("Warning: Entry couldn't be added, as there is no total available.")
        }
    }
    
    private func toAddEntry(_ wip: Entry.WIP) throws {
        let entry = try Entry(wip)
        appendEntryToHistory(entry)
    }
    
    private func appendEntryToHistory(_ entry: Entry) {
        history.append(entry)
    }
    
}

extension AppState {
    static var currencyCode: String { Locale.current.currencyCode ?? "USD" }
}

// MARK: - (persistence methods)
fileprivate extension Array where Element == Entry {
    private var persistor: DocumentsDirectoryPersistor<Self> { DocumentsDirectoryPersistor(objectToPersist: self) }
    
    func save() {
        do {
            try persistor.save()
        } catch {
            print("saving entries failed: \(error)")
        }
    }
    
    func load() {
        do {
            try persistor.load()
        } catch {
            print("loading entries failed: \(error)")
        }
    }
}
