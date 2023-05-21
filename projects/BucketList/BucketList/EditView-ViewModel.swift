//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation
import MyOthers

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @MainActor class ViewModel: ObservableObject {
        var location: Location, onSave: (Location) -> Void
        
        @Published var name: String
        @Published var description: String
        @Published var loadingState: LoadingState
        @Published var pages: [Page]
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            
            self._name = Published(initialValue: location.name)
            self._description = Published(initialValue: location.description)
            self.loadingState = .loading
            self.pages = [Page]()
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            let loader = URLJSONLoader<Result>(urlString: urlString)
            
            do {
                let result = try await loader.load()!
                pages = result.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
        
        func saveLocation() {
            var location = self.location
            location.id = UUID()
            location.name = name
            location.description = description
            
            onSave(location)
        }
    }
}
