//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Leopold Lemmermann on 31.10.21.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
