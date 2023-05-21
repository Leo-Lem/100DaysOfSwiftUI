//
//  DataController.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 23.11.21.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friendface")
    
    init(temporary: Bool = false) {
        if temporary {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
