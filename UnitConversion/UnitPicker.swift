//
//  UnitPicker.swift
//  UnitConversion
//
//  Created by Leopold Lemmermann on 15.12.21.
//

import SwiftUI

struct UnitPicker: View {
    private let units: [UnitLength]
    @Binding private var selector: UnitLength
    
    init(_ selector: Binding<UnitLength>, in units: [UnitLength]) {
        self.units = units
        self._selector = selector
    }
    
    var body: some View {
        Picker("", selection: $selector) {
            ForEach(units, id:\.self) { unit in
                Text(unit.symbol)
            }
        }
    }
}
