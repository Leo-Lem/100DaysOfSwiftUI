//
//  AboutView.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 21.11.21.
//

import SwiftUI

struct AboutView: View {
    let about: String
    
    var body: some View {
        NavigationLink(about) {
            Text(about)
                .multilineTextAlignment(.center)
                .padding()
        }
        .lineLimit(1)
    }
}
