//
//  WeSplitFormVM.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 25.07.22.
//

import Foundation

extension WeSplitForm {
    @MainActor final class ViewModel: ObservableObject {
        
        private let state: AppState
        init(_ state: AppState) {
            self.state = state
        }
        
        @Published var wip = Entry.WIP()
        
        var history: [Entry] { state.history }
        
        func addEntry() {
            state.addEntry(wip)
        }
        
    }
}
