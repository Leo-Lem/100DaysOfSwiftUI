//
//  RowView.swift
//  ANameToTheFace
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import SwiftUI

struct RowView: View {
    let image: ImageWithMeta
    
    var body: some View {
        HStack {
            if image.swiftUI != nil {
                CircleImage(image: image.swiftUI)
                    .frame(width: 50, height: 50)
            }
            Spacer()
            
            Text(image.name).font(.headline)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(image: ImageWithMeta.example)
            .frame(height: 100)
    }
}
