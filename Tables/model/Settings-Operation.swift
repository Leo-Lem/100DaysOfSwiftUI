//
//  Settings-Operation.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import Foundation
import MyNumbers

extension Settings {
    enum Operation: CaseIterable, Codable {
        case add, sub, mul, pow, mod
        
        func operate(_ lhs: Int, _ rhs: Int) -> Int {
            switch self {
            case .add: return lhs + rhs
            case .sub: return lhs - rhs
            case .mul: return lhs * rhs
            case .mod: return lhs % rhs
            case .pow: return lhs ** rhs
            }
        }
    }
}
