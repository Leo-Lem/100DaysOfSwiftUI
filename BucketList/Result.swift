//
//  Result.swift
//  BucketList
//
//  Created by Leopold Lemmermann on 20.12.21.
//

import Foundation

struct Result: Decodable {
    let query: Query
}

struct Query: Decodable {
    let pages: [Int: Page]
}

struct Page: Decodable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
