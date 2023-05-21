//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Leopold Lemmermann on 31.10.21.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        switch rating {
        case 1: Image(systemName: "eye.trianglebadge.exclamationmark")
        case 2: Image(systemName: "hand.thumbsdown")
        case 3: Image(systemName: "face.smiling")
        case 4: Image(systemName: "hand.thumbsup")
        default: Image(systemName: "hands.clap")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
