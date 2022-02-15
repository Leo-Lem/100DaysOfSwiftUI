//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI

struct FlagImage: View {
    let country: Country
    
    var body: some View {
        Image(country.rawValue)
            .resizable()
            .clipShape(Capsule())
            .shadow(radius: 5)
            .aspectRatio(2/1, contentMode: .fit)
            .frame(maxWidth: 200)
            .accessibilityLabel(country.accessibilityDescription)
    }
}

//MARK: - Previews
struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(country: .example)
    }
}
