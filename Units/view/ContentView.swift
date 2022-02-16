//
//  ContentView.swift
//  Units
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Section("Input") {
                TextField("Value", value: $value, format: .number)
                    .keyboardType(.decimalPad)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                ExtendedSegmentedPicker($unit.input, options: type.units, segments: 7) { unit in
                    Text(unit.symbol)
                } menuLabel: {
                    Text($0.formatted(.long))
                }
            }
            
            Section("Output") {
                ExtendedSegmentedPicker($unit.output, options: type.units, segments: 7) {
                    Text($0.symbol)
                } menuLabel: {
                    Text($0.formatted(.long))
                }
                
                GeometryReader { geo in
                    HStack(alignment: .top) {
                        VStack {
                            Text(measurement.input.formatted())
                            Text(measurement.input.unit.formatted(.long), font: .caption2.bold(), color: .secondary)
                        }
                        .frame(width: geo.size.width / 2.5)
                        
                        Spacer()
                        Text("->")
                        Spacer()
                        
                        VStack {
                            Text(measurement.output.formatted())
                            Text(measurement.output.unit.formatted(.long), font: .caption2.bold(), color: .secondary)
                        }
                        .frame(width: geo.size.width / 2.5)
                    }
                    .font(.headline)
                    .minimumScaleFactor(0.7)
                    .lineLimit(0)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(type.rawValue) {
                    Picker("Unit", selection: $type) {
                        ForEach(ConversionUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                .onChange(of: type) { newValue in self.unit = newValue.defaults }
            }
        }
        .navigationTitle("UnitConversion")
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
    
    @State private var type: ConversionUnit = .temperature
    @State private var value: Double = 1
    @State private var unit: (input: Dimension, output: Dimension) = ConversionUnit.temperature.defaults
    
    private var measurement: (input: Measurement<Dimension>, output: Measurement<Dimension>) {
        let input = Measurement(value: value, unit: unit.input)
        let output = input.converted(to: unit.output)
        
        return (input, output)
    }
}

extension Unit {
    func formatted(_ style: Formatter.UnitStyle) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = style
        return formatter.string(from: self)
    }
}

extension ContentView {
    enum ConversionUnit: String, CaseIterable {
        case temperature = "Temperature",
             length = "Length",
             time = "Time",
             volume = "Volume"
        
        var defaults: (input: Dimension, output: Dimension) {
            switch self {
            case .temperature:
                let defaults: (UnitTemperature, UnitTemperature) = (.celsius, .fahrenheit)
                return defaults
            case .length:
                let defaults: (UnitLength, UnitLength) = (.meters, .feet)
                return defaults
            case .time:
                let defaults: (UnitDuration, UnitDuration) = (.seconds, .nanoseconds)
                return defaults
            case .volume:
                let defaults: (UnitVolume, UnitVolume) = (.liters, .gallons)
                return defaults
            }
        }
        
        var units: [Dimension] {
            switch self {
            case .temperature:
                let array: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
                return array
            case .length:
                let array: [UnitLength] = [.meters, .kilometers, .inches, .feet, .miles, .yards, .parsecs, .decimeters, .centimeters, .millimeters, .micrometers, .nanometers, .picometers,  .scandinavianMiles, .lightyears, .nauticalMiles, .fathoms, .furlongs, .astronomicalUnits]
                return array
            case .time:
                let array: [UnitDuration] = [.hours, .minutes, .seconds, .milliseconds, .microseconds, .nanoseconds]
                return array
            case .volume:
                let array: [UnitVolume] = [.liters, .milliliters, .cubicMeters, .cups, .pints, .quarts, .gallons, .megaliters, .deciliters, .centiliters, .cubicKilometers, .cubicMeters, .cubicDecimeters, .cubicMillimeters, .cubicInches, .cubicFeet, .cubicYards, .cubicMiles, .acreFeet, .bushels, .teaspoons, .tablespoons, .fluidOunces, .imperialTeaspoons, .imperialTablespoons, .imperialFluidOunces, .imperialPints, .imperialQuarts, .imperialGallons, .metricCups]
                return array
            }
        }
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
