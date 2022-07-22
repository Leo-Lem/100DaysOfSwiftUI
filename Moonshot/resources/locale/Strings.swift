//
//  Strings.swift
//  Generic Strings enum for Localization
//
//  Created by Leopold Lemmermann on 21.07.22.
//

import SwiftUI
import MySwiftUI

enum Strings {
         
    case appTitle
    case displayDate, displayCrew
}

extension Strings: Localizable {
    
    prefix static func ~ (_ arg: Self) -> LocalizedStringKey { arg.key }
    
    var key: LocalizedStringKey {
        switch self {
        case .appTitle: return "APPTITLE"
        case .displayDate: return "DISPLAY_DATE"
        case .displayCrew: return "DISPLAY_CREW"
        }
    }
    
}
