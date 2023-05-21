//
//  Extensions.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 25.11.21.
//

import Foundation
import CoreData

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
    
    convenience init(context: NSManagedObjectContext , dateFormat: String) {
        self.init(context: context)
        self.dateDecodingStrategy = .formatted(DateFormatter(dateFormat: dateFormat))
    }
}
