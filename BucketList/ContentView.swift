//
//  ContentView.swift
//  BucketList
//
//  Created by Leopold Lemmermann on 11.12.21.
//

import SwiftUI
import MapKit
import MyLayout

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 25, height: 25)
                        .background(.white)
                        .clipShape(Circle())
                    
                    Text(location.name)
                        .fixedSize()
                        .padding(5)
                        .background(.black.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
                }
                .onTapGesture {
                    viewModel.selectedPlace = location
                }
            }
        }
        .ignoresSafeArea()
        .overlay {
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
                .hidden(!viewModel.isUnlocked)
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.addLocation()
            } label: {
                Image(systemName: "plus")
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding()
            }
            .hidden(!viewModel.isUnlocked)
        }
        .overlay {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: .black, radius: 20)
            .alert("Error", isPresented: $viewModel.showingErrorAlert) {
                Button("OK") {}
            } message: {
                Text(viewModel.authenticationError?.localizedDescription ?? "Try again, please.")
            }
            .hidden(viewModel.isUnlocked)
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
