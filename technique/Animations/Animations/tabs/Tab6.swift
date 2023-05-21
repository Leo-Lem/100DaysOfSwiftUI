//
//  Tab6.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI
import MyOthers

struct Tab6: View {
    var body: some View {
        Group {
            if card {
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(.roundedRectangle(cornerRadius: 10))
                    .offset(animation.offset)
                    .if(!animation.toggle) { $0.animation(.spring(), value: animation.offset) }
                    .gesture(
                        DragGesture()
                            .onChanged { animation.offset = $0.translation }
                            .onEnded { _ in
                                if animation.toggle {
                                    withAnimation(.spring()) { animation.offset = .zero }
                                } else { animation.offset = .zero }
                            }
                    )
                    .toolbar { Toggle("Explicit", isOn: $animation.toggle) }
            } else {
                HStack(spacing: 0) {
                    ForEach(0..<Array("Hello, SwiftUI!").count) {
                        Text(String(Array("Hello, SwiftUI!")[$0]), font: .title)
                            .padding(5)
                            .background(animation.toggle ? .blue : .red)
                            .offset(animation.offset)
                            .animation(.default.delay($0 / 20), value: animation.offset)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { animation.offset = $0.translation }
                        .onEnded { _ in
                            animation.offset = .zero
                            animation.toggle.toggle()
                        }
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Picker("", selection: $card) {
                    Text("Card").tag(true)
                    Text("Text").tag(false)
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    @State private var animation: (offset: CGSize, toggle: Bool) = (.zero, false)
    @State private var card = true
}

//MARK: - Previews
struct Tab6_Previews: PreviewProvider {
    static var previews: some View {
        Tab6().embedInNavigation()
    }
}
