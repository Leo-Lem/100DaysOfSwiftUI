//
//  ViewModel.swift
//  UnitConversion
//
//  Created by Leopold Lemmermann on 15.12.21.
//

import Foundation

class ViewModel {
    static let example = ViewModel(inputUnit: .kilometers, outputUnit: .miles,
                                   inputText: "10")
    
    let units: [UnitLength] = [
        .meters, .kilometers, .feet, .yards, .miles
    ]
    
    let inputMeasurementDisplay: String, outputMeasurementDisplay: String
    
    init(inputUnit: UnitLength, outputUnit: UnitLength, inputText: String) {
        let input = Double(inputText) ?? 1
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        self.inputMeasurementDisplay = inputMeasurement.formattedAsString()
        self.outputMeasurementDisplay = outputMeasurement.formattedAsString()
    }
}

extension MeasurementFormatter {
    convenience init(unitOptions: MeasurementFormatter.UnitOptions,
                     decimalPoints: Int) {
        self.init()
        self.unitOptions = unitOptions
        self.numberFormatter.maximumFractionDigits = decimalPoints
    }
}

extension Measurement where UnitType: UnitLength {
    func formattedAsString() -> String {
        MeasurementFormatter(unitOptions: .providedUnit, decimalPoints: 3)
            .string(from: self)
    }
}
