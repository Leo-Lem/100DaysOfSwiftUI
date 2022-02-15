//
//  AccesibilityDescriptions.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import Foundation

extension Country {
    var accessibilityDescription: String {
        switch self {
        case .estonia:
            return "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white"
        case .france:
            return "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red"
        case .germany:
            return "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold"
        case .ireland:
            return "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange"
        case .italy:
            return "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red"
        case .nigeria:
            return "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green"
        case .poland:
            return "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red"
        case .russia:
            return "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red"
        case .spain:
            return "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red"
        case .uk:
            return "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background"
        case .us:
            return "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
        }
    }
}
