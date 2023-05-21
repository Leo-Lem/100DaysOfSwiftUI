//
//  LogoView.swift
//  Tables
//
//  Created by Leopold Lemmermann on 21.02.22.
//

import SwiftUI
import MyStorage

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
                        .system(size: min(geo.size.width, geo.size.height) * 0.15)
                        .bold()
                        .lowercaseSmallCaps()
                    )
            }
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

extension LogoView {
    init(
        _ title: String? = nil,
        image: Image
    ) {
        self.title = title ?? Bundle.main.displayName ?? ""
        self.image = image
    }
    
    init(_ title: String? = nil, image: String) {
        self.init(title, image: Image(image))
    }
    
    init(_ title: String? = nil, systemImage: String) {
        self.init(title, image: Image(systemName: systemImage))
    }
}

//MARK: - Previews
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView("MultiTables", systemImage: "xmark")
    }
}
