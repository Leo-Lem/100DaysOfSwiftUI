//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!", font: .largeTitle)
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.", color: .secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
