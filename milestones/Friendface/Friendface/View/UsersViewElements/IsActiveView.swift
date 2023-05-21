//
//  IsActiveView.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 21.11.21.
//

import SwiftUI

struct IsActiveView: View {
    let isActive: Bool
    
    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(isActive ? .green : .gray)
    }
}

extension IsActiveView {
    init(_ isActive: Bool = false) {
        self.isActive = isActive
    }
}
