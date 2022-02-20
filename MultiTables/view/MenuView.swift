//
//  MenuView.swift
//  MultiTables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MySwiftUI

struct MenuView: View {
    @Binding var settings: Settings
    let newGame: () -> Void
        
    var body: some View {
        let binding = Binding<Double>(get: { Double(settings.questions) }, set: { settings.questions = Int($0) })
        
        Form {
            Section("Up to what number?") {
                Stepper("\(settings.table)", value: $settings.table, in: 6...20)
            }
            
            Section("How many questions (\(settings.questions))?") {
                Slider(
                    value: binding,
                    in: 2...Double(settings.maxQuestions),
                    step: 1,
                    minimumValueLabel: Text("2"),
                    maximumValueLabel: Text("\(settings.maxQuestions)")
                ) {}
            }
            
            Section("Which operator?") {
                Picker(
                    "",
                    selection: $settings.operation,
                    items: Settings.Operation.allCases,
                    id: \.self
                ) { Text($0.rawValue) }
                    .pickerStyle(.segmented)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button("Start new game with these settings", action: newGame).buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("What to practice?")
        .embedInNavigation()
    }
}

//MARK: - Previews
struct MenuView_Previews: PreviewProvider {
    private static let settings: Settings = .default
    
    static var previews: some View {
        PreviewBinding(settings) { MenuView(settings: $0) {} }
    }
}
