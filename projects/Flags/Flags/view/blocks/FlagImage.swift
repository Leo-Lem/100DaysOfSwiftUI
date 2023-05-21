//
//  FlagImage.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import SwiftUI
import MySwiftUI

extension FlagsView {
    struct FlagImage: View {
        let country: Country
        
        var body: some View {
            Image(country.id)
                .resizable()
                .interpolation(.high)
                .brightness(-0.1)
                .clipShape(.capsule)
                .shadow(radius: 10)
                .aspectRatio(1.8/1, contentMode: .fit)
                .frame(maxWidth: 200)
        }
    }
}

//MARK: - Previews
struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView.FlagImage(country: .example)
    }
}
