//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Leopold Lemmermann on 03.11.21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var lastName: String?
    var wrappedLastName: String { lastName ?? "Unknown" }
    @NSManaged public var firstName: String?
    var wrappedFirstName: String { firstName ?? "Unknown" }

}

extension Singer : Identifiable {

}
