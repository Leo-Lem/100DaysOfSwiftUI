//
//  Tab3.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab3: View {
    var body: some View {
        VStack {
            Button("Hello, Kinsman!", toggle: $colors.red)
                .foregroundColor(colors.red ? .red : .blue)
            
            Divider()
            
            if colors.green {
                Button("Hello, Friend!", toggle: $colors.green)
                    .foregroundColor(.green)
            } else {
                Button("Hello, Friend!", toggle: $colors.green)
                    .foregroundColor(.blue)
            }
            
            Divider()
            
            Button("Hello, World!", toggle: $colors.yellow)
                .if(colors.yellow) { $0.foregroundColor(.yellow) }
        }
        .buttonStyle(.borderless)
    }
    
    @State private var colors: (red: Bool, green: Bool, yellow: Bool) = (false, false, false)
}

//MARK: - Previews
struct Tab3_Previews: PreviewProvider {
    static var previews: some View {
        Tab3()
    }
}
