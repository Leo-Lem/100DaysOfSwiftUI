//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Leopold Lemmermann on 10.11.21.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    public var wrappedName: String {
        get { name ?? "Unknown Candy" }
        set { self.name = newValue }
    }
    @NSManaged public var origin: Country?

}

extension Candy : Identifiable {

}
