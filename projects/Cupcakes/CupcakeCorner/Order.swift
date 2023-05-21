//
//  Order.swift
//  CupcakeCorner
//
//  Created by Leopold Lemmermann on 08.10.21.
//

import Foundation

class Order: ObservableObject {
    @Published var data = OrderData()
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    struct OrderData: Codable {
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var hasValidAdress: Bool {
            if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
            
            return true
        }
        
        var cost: Double {
            var cost = Double(quantity) * 2
            
            cost += Double(type) / 2
            
            if extraFrosting { cost += Double(quantity) }
            
            if addSprinkles { cost += Double(quantity) / 2 }
            
            return cost
        }
    }
    
    /*enum CodingKeys: CodingKey { case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    init() { }*/
}
