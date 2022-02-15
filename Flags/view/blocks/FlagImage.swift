//
//  FlagImage.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import SwiftUI

extension FlagsView {
    struct FlagImage: View {
        let country: Country
        
        var body: some View {
            Image(country.rawValue)
                .resizable()
                .brightness(-0.1)
                .clipShape(Capsule())
                .shadow(radius: 10)
                .aspectRatio(1.8/1, contentMode: .fit)
                .frame(maxWidth: 200)
                .accessibilityLabel(country.accessibilityDescription)
        }
    }
}

//MARK: - Previews
struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView.FlagImage(country: .example)
    }
}
