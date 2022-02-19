//
//  Tab1.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab1: View {
    var body: some View {
        Text("Hello, world!")
            .if(toggle) { $0
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else: { $0
                .padding()
            }
            .background(.red)
            .toolbar { Toggle("Max-Frame", isOn: $toggle)}
    }
    
    @State private var toggle = false
}

//MARK: - Previews
struct Tab1_Previews: PreviewProvider {
    static var previews: some View {
        Tab1().embedInNavigation()
    }
}
