//
//  Tab1.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab1: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(.red)
                
            Text("Hello, world!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
        }
        .frame(height: 400)
    }
}

//MARK: - Previews
struct Tab1_Previews: PreviewProvider {
    static var previews: some View {
        Tab1()
    }
}
