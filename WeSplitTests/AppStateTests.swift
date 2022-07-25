//
//  WeSplitTests.swift
//  WeSplitTests
//
//  Created by Leopold Lemmermann on 25.07.22.
//

import XCTest
@testable import WeSplit

class AppStateTests: XCTestCase {

    private var state = AppState()
    override func setUp() { state = AppState() }
    override func tearDown() { state.deleteHistory() }

    func testSavingAndLoadingHistory() {
        let entry = Entry.random
        state.history.append(entry)
        
        state = AppState()
        let loadedEntry = state.history.first
        
        XCTAssertEqual(entry.id, loadedEntry?.id)
    }
    
    func testDeletingHistory() {
        state.deleteHistory()
        
        XCTAssertTrue(state.history.isEmpty)
        
        state = AppState()
        XCTAssertTrue(state.history.isEmpty, "The History is not empty after reloading the AppState.")
    }
    
    func testAddingEntry() {
        var wip = Entry.WIP()
        
        // trying to save without a total
        state.addEntry(wip)
        XCTAssertTrue(state.history.isEmpty, "Entry was not saved without a valid total value.")
        
        // saving with a valid total
        wip = .random
        state.addEntry(wip)
        XCTAssertEqual(state.history.first?.total, wip.total, "The total of the saved entry doesn't match.")
    }

    func testPerformanceOfAddingEntries() {
        measure {
            setUp()
            for _ in 1...100 {
                state.addEntry(.random)
            }
            print(state.history[0...5])
            tearDown()
        }
    }

}

// MARK: - (Helpers for testing)
extension AppState {
    
    fileprivate func deleteHistory() { history = [] }
    
}

extension Entry.WIP {
    
    static var random: Entry.WIP {
        Entry.WIP(
            total: .random(in: 0.1...10000),
            people: .random(in: 2...50),
            tip: .random(in: 0.0...0.8)
        )
    }
    
}

extension Entry {
    
    static var random: Entry { Entry(.random)! }
    
}
