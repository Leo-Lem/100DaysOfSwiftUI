//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .frame(width: 40, height: 25)
                            .cornerRadius(5, border: (.black, 1))
                            
                        VStack(alignment: .leading) {
                            Text(resort.name, font: .headline)
                            Text("\(resort.runs) runs", color: .secondary)
                        }
                        
                        Spacer()
                            
                        Button(systemImage: fc.contains(resort) ? "heart.fill" : "heart") {
                            fc.contains(resort) ? fc.remove(resort) : fc.add(resort)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
            .searchable(text: $search, prompt: "Search for a resort")
            .navigationTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack(spacing: 0) {
                        Text("sort order: ")
                        Menu(sortOrder.rawValue) {
                            ForEach(SortOrder.allCases, id: \.self) { order in
                                Button(order.rawValue) { self.sortOrder = order }
                            }
                        }
                    }
                }
            }
            
            WelcomeView()
        }
        .environmentObject(fc)
    }
    
    private var resorts: [Resort] {
        let filtered = search.isEmpty ? Resort.resorts : Resort.resorts.filter { $0.name.localizedCaseInsensitiveContains(search) }
        return sortOrder.sort(filtered)
    }
    
    @State private var search: String = ""
    @State private var sortOrder: SortOrder = .default
    
    @StateObject private var fc = FavoritesController()
    
    enum SortOrder: String, CaseIterable {
        case `default` = "Default",
             name = "Alphabetical",
             country = "Country",
             runs = "Runs"
        
        func sort(_ resorts: [Resort]) -> [Resort] {
            switch self {
            case .name: return resorts.sorted(by: \.name)
            case .country: return resorts.sorted(by: \.country)
            case .runs: return resorts.sorted(by: \.runs).reversed()
            default: return resorts
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
