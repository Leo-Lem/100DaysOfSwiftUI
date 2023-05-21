//
//  Tab5.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab5: View {
    var body: some View {
        VStack {
            motto.0.foregroundColor(.red)
            motto.1.foregroundColor(.blue)
        }
    }
    
    let motto = (Text("Draco dormiens"), Text("nunquam titillandus"))
}

//MARK: - Previews
struct Tab5_Previews: PreviewProvider {
    static var previews: some View {
        Tab5()
    }
}
