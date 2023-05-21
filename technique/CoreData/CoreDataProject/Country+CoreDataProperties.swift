//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Leopold Lemmermann on 10.11.21.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var shortName: String?
    public var wrappedShortName: String { shortName ?? "Unknown Country" }
    @NSManaged public var fullName: String?
    public var wrappedFullName: String { fullName ?? "Unknown Country" }
    @NSManaged public var candy: NSSet?
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: Set<Candy>)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: Set<Candy>)

}

extension Country : Identifiable {

}
