//
//  TapMeButton.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct TapMeButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Tap Me", action: action)
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(.circle)
    }
}

//MARK: - Previews
struct TapMeButton_Previews: PreviewProvider {
    private static let animationAmount = 1.0
    
    static var previews: some View {
        TapMeButton {}
    }
}
