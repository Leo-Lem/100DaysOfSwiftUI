//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import Foundation
import MyStorage

class FavoritesController: ObservableObject {
    private var favorites: Set<String> {
        willSet { objectWillChange.send() }
        didSet { save() }
    }
    
    private let key = "Favorites"
    init() { favorites = UserDefaults.standard.getObject(forKey: key, castTo: Set<String>.self) ?? [] }
    func save() { UserDefaults.standard.setObject(favorites, forKey: key) }
    
    func contains(_ resort: Resort) -> Bool { favorites.contains(resort.id) }
    func add(_ resort: Resort) { favorites.insert(resort.id) }
    func remove(_ resort: Resort) { favorites.remove(resort.id) }
}
