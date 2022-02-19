//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    @State private var section: Int = 0
    
    var body: some View {
        TabView(selection: $section) {
                
            Tab1().tag(1)
                .navigationTitle(".background")
                
            Tab2().tag(2)
                .navigationTitle("Modifier Order")
                
            Tab3().tag(3)
                .navigationTitle("Conditional Modifiers")
                
            Tab4().tag(4)
                .navigationTitle("Environment Modifiers")
                
            Tab5().tag(5)
                .navigationTitle("Views as Properties")
                
            Tab6().tag(6)
                .navigationTitle("View Composition")
                
            Tab7().tag(7)
                .navigationTitle("Custom Modifiers")
                
            Tab8().tag(8)
                .navigationTitle("custom containers")
                
        }
        .border(.primary)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Select Tab", selection: $section, items: 0..<8) { Text("\($0 + 1)") }
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
