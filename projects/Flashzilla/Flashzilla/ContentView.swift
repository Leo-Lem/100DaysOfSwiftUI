//
//  ContentView.swift
//  Flashzilla
//
//  Created by Leopold Lemmermann on 24.01.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<cards.count, id: \.self) { index in
                    CardView(card: cards[index]) {
                        withAnimation { removeCard(at: index) }
                    }
                    .stacked(at: index, in: cards.count)
                    .allowsHitTesting(index == cards.count-1)
                    .accessibilityHidden(index < cards.count - 1)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(image: "background")
    }
    
    @State private var cards = [Card](repeating: .example, count: 10)
    
    private func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
