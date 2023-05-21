//
//  Tab2.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct Tab2: View {
    var body: some View {
        TapMeButton { animation.amount += 1 }
            .disabled(overlay)
            .if(overlay) { $0
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animation.amount)
                        .opacity(2 - animation.amount)
                        .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animation.amount)
                )
            } else: { view in
                view
                    .scaleEffect(animation.amount)
                    .animation(animations[animation.kind], value: animation.amount)
                    .toolbar {
                        ToolbarItem {
                            Picker("Select Animation", selection: $animation.kind) {
                                Text("EaseOut").tag(0)
                                Text("Spring").tag(1)
                                Text("EaseInOut").tag(2)
                                Text("Delay").tag(3)
                                Text("Repeat (3)").tag(4)
                                Text("Repeat Forever").tag(5)
                            }
                            .pickerStyle(.menu)
                        }
                        
                        ToolbarItem(placement: .primaryAction) {
                            Button("Reset") { animation = (0, 1) }
                        }
                    }
                    
            }
            .onChange(of: overlay) { animation.amount = $0 ? 2 : 1 }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("", selection: $overlay) {
                        Text("Interactive").tag(false)
                        Text("Continuous").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
            }
    }
    
    @State private var overlay = false
    @State private var animation: (kind: Int, amount: Double) = (0, 1)
    private let animations: [Animation] = [
        .easeOut,
        .interpolatingSpring(stiffness: 50, damping: 1),
        .easeInOut(duration: 2),
        .easeInOut(duration: 2).delay(1),
        .easeInOut(duration: 1).repeatCount(3, autoreverses: true),
        .easeInOut(duration: 1).repeatForever(autoreverses: true)
    ]
}

//MARK: - Previews
struct Tab2_Previews: PreviewProvider {
    static var previews: some View {
        Tab2().embedInNavigation()
    }
}
