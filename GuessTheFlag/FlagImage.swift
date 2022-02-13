//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 31.07.21.
//

import SwiftUI

struct FlagImage: View {
    var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var number: Int = 0
    
    var body: some View {
        Image(countries[number])
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 10)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage()
    }
}
