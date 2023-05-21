//
//  WeSplitApp.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI

@main
struct WeSplitApp: App {
    
    @StateObject private var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            WeSplitForm()
                .environmentObject(state)
        }
    }
    
}
