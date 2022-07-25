//
//  Entry-WIP.swift
//  WeSplit
//
//  Created by Leopold Lemmermann on 25.07.22.
//

import Foundation

extension Entry {
    struct WIP {
        
        private var _total: Double?, _people: Int, _tip: Double
        
        var isTotalSet: Bool { _total != nil }
        var total: Double? {
            get { _total }
            set {
                if let newTotal = newValue { _total = newTotal }
            }
        }
        
        static let peopleLimits = 2...50
        var people: Int {
            get { _people }
            set {
                if Self.peopleLimits ~= newValue { _people = newValue }
            }
        }
        
        static let tipLimits = 0.0...0.8
        var tip: Double {
            get { _tip }
            set {
                if Self.tipLimits ~= newValue { _tip = newValue }
            }
        }
        
        init(total: Double? = nil, people: Int = 2, tip: Double = 0.2) {
            _total = total
            _people = people
            _tip = tip
        }
        
    }
}
