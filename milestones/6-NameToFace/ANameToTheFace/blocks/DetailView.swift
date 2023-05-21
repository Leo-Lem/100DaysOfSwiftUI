//
//  DetailView.swift
//  ANameToTheFace
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let image: ImageWithMeta
    @State private var coordinateRegion: MKCoordinateRegion
    var showingMap: Bool { image.region == nil ? false : true }
    
    var body: some View {
        VStack {
            Divider()
            image.swiftUI?
                .resizable()
                .scaledToFill()
                .navigationTitle(image.name)
                .navigationBarTitleDisplayMode(.inline)
            if showingMap {
                Divider()
                Map(coordinateRegion: $coordinateRegion)
            }
        }
    }
    
    init(image: ImageWithMeta) {
        self.image = image
        self._coordinateRegion = State(initialValue: image.region ?? MKCoordinateRegion())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: ImageWithMeta.example)
    }
}
