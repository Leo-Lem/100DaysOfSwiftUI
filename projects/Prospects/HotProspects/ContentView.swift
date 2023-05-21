//
//  ContentView.swift
//  HotProspects
//
//  Created by Leopold Lemmermann on 07.01.22.
//

import SwiftUI
import UserNotifications

struct ContentView<P: ProspectsProtocol>: View {
    @StateObject var prospects: P
    
    var body: some View {
        TabView {
            ProspectsView<Prospects>(filter: .none)
                .tabItem { Label("Everyone", systemImage: "person.3") }
            
            ProspectsView<Prospects>(filter: .contacted)
                .tabItem { Label("Contacted", systemImage: "checkmark.circle") }
            
            ProspectsView<Prospects>(filter: .uncontacted)
                .tabItem { Label("Uncontacted", systemImage: "questionmark.diamond") }
            
            MeView()
                .tabItem { Label("Me", systemImage: "person.crop.square") }
        }
        .environmentObject(prospects)
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(prospects: MockProspects())
    }
}
