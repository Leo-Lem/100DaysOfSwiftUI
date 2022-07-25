//
//  WeSplitFormVMTests.swift
//  WeSplitTests
//
//  Created by Leopold Lemmermann on 25.07.22.
//

import XCTest
@testable import WeSplit

@MainActor class WeSplitFormVMTests: XCTestCase {

    private var state: AppState!
    private var vm: WeSplitForm.ViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        state = AppState()
        vm = .init(state)
    }
    
    func testAddingEntry() {
        let entry = Entry.WIP.random
        vm.wip = entry
        vm.addEntry()
        vm.wip = .init()
        
        XCTAssertEqual(vm.history.last?.total, entry.total)
    }
    
}
