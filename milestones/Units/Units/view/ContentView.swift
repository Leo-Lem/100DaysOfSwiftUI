//
//  ContentView.swift
//  Units
//
//  Created by Leopold Lemmermann on 16.02.22.
//

import SwiftUI
import MySwiftUI
import MyOthers

struct ContentView: View {
    var body: some View {
        Form {
            Section("Input") {
                TextField("0.0", value: $value, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($focused)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                ExtendedSegmentedPicker($unit.input, options: type.units, segments: 6) { unit in
                    Text(unit.symbol)
                } menuLabel: {
                    Text($0.formatted(.long))
                }
            }
            
            Section("Output") {
                ExtendedSegmentedPicker($unit.output, options: type.units, segments: 6) {
                    Text($0.symbol)
                } menuLabel: {
                    Text($0.formatted(.long))
                }
                
                GeometryReader { geo in
                    HStack(alignment: .top) {
                        VStack {
                            Text((measurement.input.value * 100).rounded() / 100, format: .number)
                            Text(measurement.input.unit.formatted(.long), font: .caption2.bold(), color: .secondary)
                        }
                        .frame(width: geo.size.width / 2.5)
                        
                        Spacer()
                        Text("->")
                        Spacer()
                        
                        VStack {
                            Text((measurement.output.value * 100).rounded() / 100, format: .number)
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
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done", action: { focused = false })
            }
            
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
        .navigationTitle("Units")
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
    
    @State private var type: ConversionUnit = .length
    @State private var value: Double = 1
    @State private var unit: (input: Dimension, output: Dimension) = ConversionUnit.length.defaults
    
    private var measurement: (input: Measurement<Dimension>, output: Measurement<Dimension>) {
        let input = Measurement(value: value, unit: unit.input)
        let output = input.converted(to: unit.output)
        
        return (input, output)
    }
    
    @FocusState private var focused: Bool
}

extension ContentView {
    enum Category: String, CaseIterable {
        case dimension = "Physical Dimension",
             mass = "Mass, Weight and Force",
             time = "Time and Motion",
             energy = "Energy, Heat & Light"
    }
    
    enum ConversionUnit: String, CaseIterable {
        case length = "Length",
             area = "Area",
             volume = "Volume",
             angle = "Angle",
             mass = "Weight",
             pressure = "Pressure",
             duration = "Time",
             speed = "Speed",
             energy = "Energy",
             power = "Power",
             temperature = "Temperature"
        
        var defaults: (input: Dimension, output: Dimension) {
            switch self {
            case .length: return (UnitLength.meters, UnitLength.feet)
            case .area: return (UnitArea.squareMeters, UnitArea.squareFeet)
            case .volume: return (UnitVolume.liters, UnitVolume.gallons)
            case .angle: return (UnitAngle.degrees, UnitAngle.radians)
            case .mass: return (UnitMass.grams, UnitMass.ounces)
            case .pressure: return (UnitPressure.bars, UnitPressure.kilopascals)
            case .duration: return (UnitDuration.seconds, UnitDuration.nanoseconds)
            case .speed: return (UnitSpeed.metersPerSecond, UnitSpeed.kilometersPerHour)
            case .energy: return (UnitEnergy.kilocalories, UnitEnergy.kilojoules)
            case .power: return (UnitPower.kilowatts, UnitPower.horsepower)
            case .temperature: return (UnitTemperature.celsius, UnitTemperature.fahrenheit)
            }
        }
        
        var units: [Dimension] {
            switch self {
            case .length:
                return [UnitLength.meters] + [.feet, .centimeters, .inches, .kilometers, .miles,
                                                .decimeters,  .millimeters, .micrometers, .nanometers, .picometers, .yards, .scandinavianMiles, .nauticalMiles, .fathoms, .furlongs, .lightyears, .parsecs, .astronomicalUnits]
            case .area:
                return [UnitArea.squareMeters] + [.squareFeet, .squareCentimeters, .squareInches, .squareKilometers, .squareMiles,
                                                    .squareMillimeters, .acres, .hectares, .squareMicrometers, .squareNanometers, .squareYards]
            case .volume:
                return [UnitVolume.liters] + [.milliliters, .gallons, .cubicMeters, .cups, .fluidOunces,
                                                .pints, .quarts, .megaliters, .deciliters, .centiliters, .cubicKilometers, .cubicMeters, .cubicDecimeters, .cubicMillimeters, .cubicInches, .cubicFeet, .cubicYards, .cubicMiles, .acreFeet, .bushels, .teaspoons, .tablespoons, .imperialTeaspoons, .imperialTablespoons, .imperialFluidOunces, .imperialPints, .imperialQuarts, .imperialGallons, .metricCups]
            case .angle:
                return [UnitAngle.degrees] + [.radians, .gradians, .revolutions, .arcMinutes, .arcSeconds]
            case .mass:
                return [UnitMass.kilograms] + [.pounds, .grams, .stones, .metricTons, .ounces, .decigrams, .centigrams, .milligrams, .micrograms, .nanograms, .picograms, .shortTons, .carats, .ouncesTroy, .slugs]
            case .pressure:
                return [UnitPressure.newtonsPerMetersSquared] + [.bars, .kilopascals, .poundsForcePerSquareInch, .inchesOfMercury, .millibars,
                                                                 .millimetersOfMercury, .gigapascals, .megapascals,  .hectopascals]
            case .duration:
                return [UnitDuration.seconds] + [.hours, .minutes, .milliseconds, .nanoseconds, .picoseconds, .microseconds]
            case .speed:
                return [UnitSpeed.metersPerSecond] + [.kilometersPerHour, .milesPerHour, .knots]
            case .energy:
                return [UnitEnergy.joules] + [.calories, .kilojoules, .kilocalories, .kilowattHours]
            case .power:
                return [UnitPower.horsepower] + [.kilowatts, .milliwatts, .watts]
            case .temperature:
                return [UnitTemperature.celsius] + [.fahrenheit, .kelvin]
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
