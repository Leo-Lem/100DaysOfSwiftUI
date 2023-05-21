//
//  LogoView.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 21.02.22.
//

import SwiftUI
import MySwiftUI

struct LogoView: View {
    let title: String, image: Image
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: geo.size.width / 2)
                
                Text(title)
                    .font(
                        .system(size: min(geo.size.width, geo.size.height) * 0.1)
                        .bold()
                        .lowercaseSmallCaps()
                    )
            }
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

//MARK: - Previews
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(title: "MultiTables", image: Image(systemName: "xmark"))
    }
}
