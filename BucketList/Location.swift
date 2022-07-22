//
//  Location.swift
//  BucketList
//
//  Created by Leopold Lemmermann on 13.12.21.
//

import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID, name: String, description: String
    let latitude: Double, longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(),
                                  name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.",
                                  latitude: 51.501, longitude: -0.141)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
