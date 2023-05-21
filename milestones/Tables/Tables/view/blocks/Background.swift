//
//  Background.swift
//  Tables
//
//  Created by Leopold Lemmermann on 21.02.22.
//

import SwiftUI
import MySwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                RadialGradient(colors: colors, center: .top, startRadius: 50, endRadius: 250)
                RadialGradient(colors: [.cyan, .white], center: .bottom, startRadius: 50, endRadius: 300)
            }
            
            LinearGradient(colors: [.red, .green, .cyan], startPoint: .leading, endPoint: .trailing)
                .opacity(0.2)
        }
    }
    
    private let colors: [Color] = [.cyan, .white]
}

//MARK: - Previews
struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background().ignoresSafeArea()
    }
}
