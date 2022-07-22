//
//  Card.swift
//  Flashzilla
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import Foundation

struct Card {
    let prompt: String, answer: String
}

extension Card {
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
