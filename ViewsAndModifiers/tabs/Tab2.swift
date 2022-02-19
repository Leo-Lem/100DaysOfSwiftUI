//
//  Tab2.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab2: View {
    var body: some View {
        VStack {
            Button("Hello, world!", action: { print(type(of: self.body)) })
                .background(.red)
                .frame(width: 150, height: 150)
            
            Button("Hello, world!", action: { print(type(of: self.body)) })
                .frame(width: 150, height: 150)
                .background(.red)
            
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
        }
    }
}

//MARK: - Previews
struct Tab2_Previews: PreviewProvider {
    static var previews: some View {
        Tab2()
    }
}
