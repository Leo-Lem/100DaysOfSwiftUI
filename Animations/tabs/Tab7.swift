//
//  Tab7.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab7: View {
    var body: some View {
        VStack {
            Button("Tap Me", toggle: $red.animation())
            if red {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(asymmetric ? .asymmetric(insertion: .scale, removal: .slide) : .scale)
            }
        }
        .toolbar {
            Toggle("Asymmetric", isOn: $asymmetric)
        }
    }
    
    @State private var red = false
    @State private var asymmetric = false
}

//MARK: - Previews
struct Tab7_Previews: PreviewProvider {
    static var previews: some View {
        Tab7().embedInNavigation()
    }
}
