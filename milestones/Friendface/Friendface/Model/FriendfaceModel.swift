//
//  CoreData-Model.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 24.11.21.
//

import CoreData
import SwiftUI

func addToContext<T: NSManagedObject>(_ objects: Array<T>, context: NSManagedObjectContext) {
    objects.forEach { object in
        let item = T(context: context)
        item.entity.attributesByName.keys.forEach { attribute in
            item.setValue(object.value(forKey: attribute), forKey: attribute)
        }
    }
}

class User: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey { case id, isActive, name, age, company, email, address, about, registered, tags, friends }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Decoding failed!")
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive) ?? false
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decodeIfPresent(Int16.self, forKey: .age) ?? 0
        self.company = try container.decodeIfPresent(String.self, forKey: .company) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        self.about = try container.decodeIfPresent(String.self, forKey: .about) ?? ""
        self.registered = try container.decodeIfPresent(Date.self, forKey: .registered) ?? Date()
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        self.friends = (try container.decodeIfPresent(Set<User>.self, forKey: .friends)) as NSSet?
    }
}

extension User {
    public var wrappedId: UUID { self.id ?? UUID() }
    public var wrappedRegistered: Date { self.registered ?? Date() }
    public var wrappedName: String { self.name ?? "Unknown" }
    public var wrappedCompany: String { self.company ?? "Company N/A" }
    public var wrappedEmail: String { self.email ?? "Email N/A" }
    public var wrappedAddress: String { self.address ?? "Address N/A" }
    public var wrappedAbout: String { self.about ?? "" }
    public var wrappedTags: [String] { self.tags ?? [] }
    
    public var friendsArray: [User] {
        Array(friends as? Set<User> ?? [])
    }
}
