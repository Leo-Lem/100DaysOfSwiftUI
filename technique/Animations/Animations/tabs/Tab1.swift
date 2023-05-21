//
//  Tab1.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab1: View {
    var body: some View {
        TapMeButton { animationAmount += 1 }
            .scaleEffect(animationAmount)
            .blur(radius: (animationAmount - 1) * 3)
            .animation(animationAmount)
            .toolbar { Button("Reset") { animationAmount = 1 } }
    }
    
    @State private var animationAmount: Double = 1
}

//MARK: - Previews
struct Tab1_Previews: PreviewProvider {
    static var previews: some View {
        Tab1().embedInNavigation()
    }
}
