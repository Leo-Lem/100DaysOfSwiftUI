//
//  ViewModel.swift
//  BucketList
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import SwiftUI
import MapKit
import MyOthers
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var locations = [Location]()
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        @Published var authenticationError: Error?
        @Published var showingErrorAlert = false
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New Location", description: "",
                                       latitude: mapRegion.center.latitude,
                                       longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                            self.load()
                            self.isUnlocked = true
                        }
                    } else {
                        Task { @MainActor in
                            self.authenticationError = authenticationError
                            self.showingErrorAlert = true
                        }
                    }
                }
            } else {
                //no biometrics
            }
        }
        
        private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        private func load() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
