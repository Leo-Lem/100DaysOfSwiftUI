//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Leopold Lemmermann on 02.11.21.
//

import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        persistenceController.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
