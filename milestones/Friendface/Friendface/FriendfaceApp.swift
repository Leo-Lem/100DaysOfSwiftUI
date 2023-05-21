//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 10.11.21.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            UsersView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
