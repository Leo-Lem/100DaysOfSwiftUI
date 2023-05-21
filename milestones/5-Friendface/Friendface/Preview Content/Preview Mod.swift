//
//  Previews.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 23.11.21.
//

import SwiftUI

struct Previews: ViewModifier {
    @StateObject private var dataController = DataController(temporary: true)
    
    func body(content: Content) -> some View {
        content
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

extension View {
    func previews() -> some View {
        modifier(Previews())
    }
}
