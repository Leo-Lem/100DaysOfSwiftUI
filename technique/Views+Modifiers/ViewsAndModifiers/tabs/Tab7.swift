//
//  Tab7.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI

struct Tab7: View {
    var body: some View {
        VStack {
            Text("Hello, world!").modifier(Title())
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
            Text("This is a title").prominentTitle()
        }
    }
}

extension View {
    func titleStyle() -> some View { modifier(Title()) }
    func watermarked(with text: String) -> some View { modifier(Watermark(text: text)) }
    func prominentTitle() -> some View { modifier(ProminentTitle()) }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(.roundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    let text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

//MARK: - Previews
struct Tab7_Previews: PreviewProvider {
    static var previews: some View {
        Tab7()
    }
}
