//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Leopold Lemmermann on 07.01.22.
//

import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(prospects: Prospects())
        }
    }
}
