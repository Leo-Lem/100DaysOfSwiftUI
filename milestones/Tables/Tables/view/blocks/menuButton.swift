//
//  menuButton.swift
//  Tables
//
//  Created by Leopold Lemmermann on 21.02.22.
//

import SwiftUI

extension View {
    func menuButton() -> some View {
        VStack {
            Divider()
            self.font(.title.weight(.semibold))
            Divider()
        }
        .foregroundColor(.primary)
        .background(.regularMaterial)
    }
}
