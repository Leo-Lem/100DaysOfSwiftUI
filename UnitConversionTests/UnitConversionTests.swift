//
//  UnitConversionTests.swift
//  UnitConversionTests
//
//  Created by Leopold Lemmermann on 15.12.21.
//

import XCTest
@testable import UnitConversion

class UnitConversionTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testMeasurementFormatterFormatsCorrect() {
        let measurement = Measurement(value: 10.1234, unit: UnitLength.meters)
        let formatter = MeasurementFormatter(unitOptions: .providedUnit, decimalPoints: 3)
        let formattedMeasurement = formatter.string(from: measurement)
        
        XCTAssertEqual(formattedMeasurement, "10.123 m")
    }
    
    func testMeasurementFormattedAsStringIsCorrect() {
        let measurement = Measurement(value: 10.1234, unit: UnitLength.meters)
        let formattedMeasurement = measurement.formattedAsString()
        
        XCTAssertEqual(formattedMeasurement, "10.123 m")
    }
    
    func testUnitsArrayInitializes() {
        let model = ViewModel.example
        
        XCTAssertFalse(model.units.isEmpty)
    }
    
    func testInputMeasurementIsConvertedToString() {
        let model = ViewModel.example
        
        XCTAssertNotNil(model.inputMeasurementDisplay)
    }
    
    func testOutputMeasurementIsConvertedToString() {
        let model = ViewModel.example
        
        XCTAssertNotNil(model.outputMeasurementDisplay)
    }
    
    func testViewModelRefreshesOnInput() {
        var inputText = "1"
        var model: ViewModel {
            ViewModel(inputUnit: .meters, outputUnit: .meters, inputText: inputText)
        }
        inputText = "3"
        
        XCTAssertEqual (model.outputMeasurementDisplay, "3 m")
    }
    
    
}
