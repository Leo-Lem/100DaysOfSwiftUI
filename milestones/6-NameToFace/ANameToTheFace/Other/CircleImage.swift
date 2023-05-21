//
//  CircleImage.swift
//  Landmarks
//
//  Created by Leopold Lemmermann on 02.01.22.
//

import SwiftUI

struct CircleImage: View {
    let image: Image?
    
    var body: some View {
        image?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 3)
            }
            .shadow(radius: 5)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: ImageWithMeta.example.swiftUI)
    }
}
