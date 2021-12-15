//
//  ContentView.swift
//  UnitConversion
//
//  Created by Leopold Lemmermann on 31.07.21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit: UnitLength = .meters
    @State private var outputUnit: UnitLength = .meters
    @State private var inputText = ""
    
    private var viewModel: ViewModel {
        ViewModel(inputUnit: inputUnit, outputUnit: outputUnit, inputText: inputText)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Input") {
                    TextField("1", text: $inputText)
                        .keyboardType(.decimalPad)
                }
                
                Section("Input Unit") {
                    UnitPicker($inputUnit, in: viewModel.units)
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section("Output Unit") {
                    UnitPicker($outputUnit, in: viewModel.units)
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section("Output") {
                    Text("\(viewModel.inputMeasurementDisplay) -> \(viewModel.outputMeasurementDisplay)")
                }
            }
            .navigationTitle("UnitConversion")
            //TODO: add settings to select possible conversion units
            /*.toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gear.circle")
                            .foregroundColor(.primary)
                    }
                }
            }*/
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
