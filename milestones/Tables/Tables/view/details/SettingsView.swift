//
//  SettingsView.swift
//  Tables
//
//  Created by Leopold Lemmermann on 21.02.22.
//

import SwiftUI
import MySwiftUI

struct SettingsView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        //TODO: Redesign this to make it look nicer
        let questions = Binding<Double>(
            get: { Double(state.settings.questions) },
            set: { state.settings.questions = Int($0) }
        )
        
        Form {
            Section("Up to what number?") {
                Stepper("\(state.settings.table)", value: $state.settings.table, in: 6...20)
            }
            
            Section("How many questions (\(state.settings.questions))?") {
                Slider(
                    value: questions,
                    in: 2...Double(state.settings.maxQuestions),
                    step: 1,
                    minimumValueLabel: Text("2"),
                    maximumValueLabel: Text("\(state.settings.maxQuestions)")
                ) {}
            }
            
            Section("Which operator?") {
                Picker(
                    "",
                    selection: $state.settings.operation,
                    items: Settings.Operation.allCases,
                    id: \.self
                ) { Text($0.symbol) }
                    .pickerStyle(.segmented)
            }
        }
    }
}

//MARK: - Previews
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppState())
            .embedInNavigation()
    }
}
