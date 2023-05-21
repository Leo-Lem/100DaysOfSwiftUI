//
//  Resort.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import Foundation
import MyOthers
import MyStorage

struct Resort: Decodable, Identifiable {
    let id: String,
        name: String,
        country: String,
        description: String,
        imageCredit: String,
        price: Int,
        size: Int,
        snowDepth: Int,
        elevation: Int,
        runs: Int,
        facilities: [String]
    
    var facilitiesObjects: [Facility] { facilities.compactMap { Facility(rawValue: $0) } }
}

extension Resort: Example {
    static let resorts: [Resort] = {
        do { return try Bundle.main.load("resorts.json") } catch {
            print(error)
            return []
        }
    }()
    static let example = resorts[0]
}
