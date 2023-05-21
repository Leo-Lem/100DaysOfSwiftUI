//
//  ContentView.swift
//  Animations
//
//  Created by Leopold Lemmermann on 19.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    @State private var section = 0
    
    var body: some View {
        Group {
            switch section {
            case 0: Tab1().navigationTitle("Implicit Animations")
            case 1: Tab2().navigationTitle("Custom Animations")
            case 2: Tab3().navigationTitle("Animating Bindings")
            case 3: Tab4().navigationTitle("Explicit Animations")
            case 4: Tab5().navigationTitle("Animation Stack")
            case 5: Tab6().navigationTitle("Animating Gestures")
            case 6: Tab7().navigationTitle("Transitions")
            case 7: Tab8().navigationTitle("Custom Transitions")
            default: Text("Hello, this shouldn't be reachable...")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(Divider(), alignment: .top)
        .overlay(Divider(), alignment: .bottom)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Select Tab", selection: $section, items: 0..<8) { Text($0 + 1, format: .number) }
                    .pickerStyle(.segmented)
            }
        }
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
