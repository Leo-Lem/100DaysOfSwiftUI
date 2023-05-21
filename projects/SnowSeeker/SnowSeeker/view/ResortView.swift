//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import SwiftUI
import MySwiftUI

struct ResortView: View {
    @EnvironmentObject private var fc: FavoritesController
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .bottomTrailing) {
                        Text(resort.imageCredit, font: .caption)
                            .padding(5)
                            .background(Color.secondary.opacity(0.5))
                            .cornerRadius(5)
                            .padding(5)
                    }
                
                Facilities(facilities: resort.facilitiesObjects)
                    .background(Color.primary.opacity(0.1))
                
                Text(resort.description)
                    .padding(.vertical)
                    .padding(.horizontal)
                
                //MARK: to keep the above stuff unobstructed
                Group {
                    HStack {
                        Details(resort: resort)
                        SkiDetails(resort: resort)
                    }
                    .padding()
                    .hidden()
                }
            }
        }
        .overlay(alignment: .bottom) {
            HStack {
                Details(resort: resort)
                SkiDetails(resort: resort)
            }
            .padding()
            .background(.bar)
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            fc.contains(resort) ?
            Button(systemImage: "heart.fill", action: { fc.remove(resort) }) :
            Button(systemImage: "heart", action: { fc.add(resort) })
        }
    }
    
    @Environment(\.horizontalSizeClass) var sizeClass
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: .example)
            .embedInNavigation()
            .environmentObject(FavoritesController())
    }
}
