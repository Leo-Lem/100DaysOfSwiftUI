//
//  MoonshotApp.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 18.08.21.
//

import SwiftUI

@main
struct MoonshotApp: App {
    
    @StateObject private var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            MissionsView()
                .environmentObject(state)
        }
    }
    
}
