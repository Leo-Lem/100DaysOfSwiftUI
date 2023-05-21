//
//  Tab5.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab5: View {
    var body: some View {
        Toggle("Enabled", isOn: $enabled).toggleStyle(.button)
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(nil, value: enabled)
            .clipShape(.roundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            .frame(height: enabled ? 200 : 100)
            .clipped()
            .animation(.default, value: enabled)
    }
    
    @State private var enabled = true
}

//MARK: - Previews
struct Tab5_Previews: PreviewProvider {
    static var previews: some View {
        Tab5()
    }
}
