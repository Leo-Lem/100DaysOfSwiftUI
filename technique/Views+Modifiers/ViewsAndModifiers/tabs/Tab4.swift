//
//  Tab4.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab4: View {
    var body: some View {
        HStack {
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            
            Divider()
            
            VStack {
                Text("Gryffindor")
                    .blur(radius: 0)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .blur(radius: 5)
        }
    }
}

//MARK: - Previews
struct Tab4_Previews: PreviewProvider {
    static var previews: some View {
        Tab4()
    }
}
