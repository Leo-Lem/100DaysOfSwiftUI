//
//  TablesApp.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI

@main
struct TablesApp: App {
    private let state = AppState()
    
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(state)
        }
    }
}
