//
//  CardView.swift
//  Flashzilla
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import SwiftUI
import MySwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    let card: Card
    let remove: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? .white
                        : .white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if answerShowing {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .group { view in
            view
                .padding()
                .aspectRatio(3/2, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onTapGesture { answerShowing.toggle() }
        .animation(answerShowing)
        //MARK: dragging gesture
        .group { view in
            view
                .rotationEffect(.degrees(Double(offset.width / 5)))
                .offset(x: offset.width, y: 0)
                .opacity(2 - Double(abs(offset.width / 100)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            if abs(offset.width) > 100 {
                                remove()
                            } else {
                                offset = .zero
                            }
                        }
                )
        }
        
    }
    
    @State private var answerShowing = false
    @State private var offset: CGSize = .zero
}

//MARK: - Previews
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .example) {}
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
