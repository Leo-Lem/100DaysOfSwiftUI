//
//  ContentView.swift
//  ANameToTheFace
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewmodel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.images) { image in
                    NavigationLink {
                        DetailView(image: image)
                    } label: {
                        RowView(image: image)
                    }
                }
                .onDelete { offsets in viewmodel.delete(at: offsets) }
            }
            .navigationTitle("A Name to the Face")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewmodel.showingImagePicker = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $viewmodel.showingImagePicker) {
                ImagePicker(image: $viewmodel.newImage)
                    .onChange(of: viewmodel.newImage) { _ in
                        viewmodel.showingNamePicker = true
                        focused = true
                    }
            }
            .overlay {
                if viewmodel.showingNamePicker {
                    TextField("Enter the name", text: $viewmodel.name) {
                        viewmodel.addImage()
                    }
                    .padding()
                    .background(.secondary)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .padding()
                    .focused($focused)
                }
            }
        }
    }
    
    @FocusState var focused: Bool
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
