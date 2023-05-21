//
//  EditView.swift
//  BucketList
//
//  Created by Leopold Lemmermann on 13.12.21.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(location: location, onSave: onSave))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(page.title).font(.headline)
                                    Link("Wikipedia", destination: URL(string: "https://en.wikipedia.org/?curid=\(page.pageid)")!)
                                        .font(.subheadline)
                                        .buttonStyle(.borderless)
                                }
                                Text(page.description).italic()
                            }
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
                .task { await viewModel.fetchNearbyPlaces() }
            }
            .navigationTitle("Place Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveLocation()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
    }
}
