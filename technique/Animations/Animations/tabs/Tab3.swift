//
//  Tab3.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab3: View {
    var body: some View {
        TapMeButton { animation.amount += 1}
            .scaleEffect(animation.amount)
            .toolbar {
                ToolbarItem { Toggle("Repeat", isOn: $animation.repeat) }
                
                ToolbarItem(placement: .principal) {
                    Slider(
                        value: $animation.amount
                            .animation(
                                animation.repeat ?
                                    .easeInOut(duration: 1)
                                        .repeatCount(3, autoreverses: true) :
                                            .default),
                        in: 1...10
                    )
                }
            }
    }
    
    @State private var animation: (amount: Double, `repeat`: Bool) = (1, false)
}

//MARK: - Previews
struct Tab3_Previews: PreviewProvider {
    static var previews: some View {
        Tab3().embedInNavigation()
    }
}
