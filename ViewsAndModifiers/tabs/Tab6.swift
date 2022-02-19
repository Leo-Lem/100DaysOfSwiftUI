//
//  Tab6.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab6: View {
    var body: some View {
        VStack {
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
    }
    
    struct CapsuleText: View {
        let text: String
        
        var body: some View {
            Text(text, font: .largeTitle)
                .padding()
                .background(.blue)
                .clipShape(.capsule)
        }
    }
}

//MARK: - Previews
struct Tab6_Previews: PreviewProvider {
    static var previews: some View {
        Tab6()
    }
}
