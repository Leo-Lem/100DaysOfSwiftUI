//
//  accessibility.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

extension Country {
    var accessibilityDescription: String {
        switch self {
        case .ee:
            return "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white"
        case .fr:
            return "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red"
        case .de:
            return "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold"
        case .ie:
            return "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange"
        case .it:
            return "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red"
        case .mc:
            return "Flag with two horizontal stripes of equal size. Top stripe red, bottom stripe white"
        case .ng:
            return "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green"
        case .pl:
            return "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red"
        case .ru:
            return "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red"
        case .es:
            return "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red"
        case .sh:
            return "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background"
        case .us:
            return "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
        default:
            return "More accessibility descriptions are in the progress of being added. Sorry for the inconvenience."
        }
    }
}
