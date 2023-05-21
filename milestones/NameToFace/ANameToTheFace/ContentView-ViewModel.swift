//
//  ContentView-ViewModel.swift
//  ANameToTheFace
//
//  Created by Leopold Lemmermann on 04.01.22.
//

import Foundation
import PhotosUI
import MyOthers

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showingImagePicker = false
        @Published var showingNamePicker = false
        @Published var newImage: UIImage? = nil
        @Published var name = ""
        
        var images = [ImageWithMeta]() {
            willSet { objectWillChange.send() }
            didSet { try? save(images) }
        }
        
        init() {
            self.images ?= try? load()
        }
        
        private func save(_ images: [ImageWithMeta]) throws {
            let path = FileManager.documentsDirectory.appendingPathComponent("images.json")
            
            let data = try JSONEncoder().encode(images)
            try data.write(to: path)
        }

        private func load() throws -> [ImageWithMeta] {
            let path = FileManager.documentsDirectory.appendingPathComponent("images.json")
            
            let data = try Data(contentsOf: path)
            let images = try JSONDecoder().decode([ImageWithMeta].self, from: data)
            return images
        }
        
        func delete(at offsets: IndexSet) {
            images.remove(atOffsets: offsets)
        }
        
        func addImage() {
            let manager = LocationManager()
            manager.requestLocation()
            let location = manager.location
            
            let image = ImageWithMeta(newImage, name: name, location: location)
            images.append(image)
            showingNamePicker = false
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: handle errors
        print("error with location")
    }
}
