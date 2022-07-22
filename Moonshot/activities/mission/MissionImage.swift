//
//  MissionImage.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import SwiftUI
import MySwiftUI

struct MissionImage: View {
    
    let image: Image,
        isIcon: Bool
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .aspectRatio(1, contentMode: .fit)
            .if(isIcon) { $0.frame(width: 40, height: 40) }
    }
    
    init(_ image: Image, isIcon: Bool = false) {
        self.image = image
        self.isIcon = isIcon
    }
    
}

struct MissionImage_Previews: PreviewProvider {
    static var previews: some View {
        MissionImage(Mission.example.image)
    }
}
