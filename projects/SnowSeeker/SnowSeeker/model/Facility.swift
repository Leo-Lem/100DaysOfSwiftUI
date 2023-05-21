//
//  Facility.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import Foundation

enum Facility: String, Decodable, Hashable {
    case accomodation = "Accomodation",
         beginners = "Beginners",
         crossCountry = "Cross-country",
         ecoFriendly = "Eco-friendly",
         family = "Family"
}
