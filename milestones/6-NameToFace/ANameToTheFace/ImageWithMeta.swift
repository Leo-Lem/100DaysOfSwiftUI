//
//  NamedImage.swift
//  ANameToTheFace
//
//  Created by Leopold Lemmermann on 03.01.22.
//

import SwiftUI
import CoreLocation
import MapKit

struct ImageWithMeta: Identifiable {
    var ui: UIImage?
    
    let id: UUID, timestamp: Date, location: CLLocationCoordinate2D?
    var name: String
    
    init(_ image: UIImage? = nil, name: String = "no-name", location: CLLocationCoordinate2D? = nil) {
        self.id = UUID()
        self.timestamp = Date()
        
        self.location = location
        
        self.name = name
        self.ui = image
    }
    
    var swiftUI: Image? {
        ui == nil ? nil : Image(uiImage: ui!)
    }
    var region: MKCoordinateRegion? {
        location == nil ? nil : MKCoordinateRegion(center: location!, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    static let example = ImageWithMeta(UIImage(named: "mark-wahlberg"), name: "Mark Wahlberg")
}

extension ImageWithMeta: Codable {
    enum CodingKeys: CodingKey {
        case ui, name, id, timestamp, location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.location = try container.decode(CLLocationCoordinate2D?.self, forKey: .location)
        let data = try container.decode(Data.self, forKey: .ui)
        
        if let uiImage = UIImage(data: data) {
            self.ui = uiImage
        } else { /*TODO: handle error*/ }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        let data = ui?.jpegData(compressionQuality: 0.8)
        try container.encode(data, forKey: .ui)
    }
}

extension ImageWithMeta: Equatable {
    static func ==(lhs: ImageWithMeta, rhs: ImageWithMeta) -> Bool { lhs.id == rhs.id }
}
