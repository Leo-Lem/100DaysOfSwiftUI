//
//  Tab4.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab4: View {
    var body: some View {
        TapMeButton {
            withAnimation(animation.spring ? .interpolatingSpring(stiffness: 5, damping: 1) : .default) {
                animation.amount += 360
            }
        }
        .rotation3DEffect(.degrees(animation.amount), axis: (x: 0, y: 1, z: 0))
        .toolbar { Toggle("Spring", isOn: $animation.spring) }
    }
    
    @State private var animation: (amount: Double, spring: Bool) = (1, false)
}

//MARK: - Previews
struct Tab4_Previews: PreviewProvider {
    static var previews: some View {
        Tab4().embedInNavigation()
    }
}
