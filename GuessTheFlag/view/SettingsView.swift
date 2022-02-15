//
//  SettingsView.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settings: Settings
    let new: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Number of Rounds (\(settings.rounds))") {
                    Slider(value: Binding(
                        get: { Double(settings.rounds) },
                        set: { settings.rounds = Int($0) }
                    ), in: 2...15, step: 1.0) {
                    } minimumValueLabel: {
                        Text("2")
                    } maximumValueLabel: {
                        Text("15")
                    }
                }
                
                Section("Number of Flags (\(settings.flags))") {
                    Slider(value: Binding(
                        get: { Double(settings.flags) },
                        set: { settings.flags = Int($0) }
                    ), in: 2...9, step: 1.0) {
                    } minimumValueLabel: {
                        Text("2")
                    } maximumValueLabel: {
                        Text("9")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button("Start New Game With These Settings", action: new)
                        .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#if DEBUG
//MARK: - Previews
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: .constant(AppState().settings), new: {})
    }
}
#endif
