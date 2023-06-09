//
//  FlagsView-Settings.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import SwiftUI

extension FlagsView {
    struct Settings: View {
        @Binding var settings: Flags.Settings
        let new: () -> Void
        
        var body: some View {
            NavigationView {
                Form {
                    Section(~.roundsCountLabel(settings.rounds)) {
                        Slider(
                            value: Binding(
                                get: { Double(settings.rounds) },
                                set: { settings.rounds = Int($0) }
                            ),
                            in: 2...15, step: 1.0,
                            minimumValueLabel: Text("2"),
                            maximumValueLabel: Text("15")
                        ) {}
                    }
                    
                    Section(~.flagsCountLabel(settings.flags)) {
                        Slider(
                            value: Binding(
                                get: { Double(settings.flags) },
                                set: { settings.flags = Int($0) }
                            ),
                            in: 2...9, step: 1.0,
                            minimumValueLabel: Text("2"),
                            maximumValueLabel: Text("9")
                        ) {}
                    }
                }
                .navigationTitle(~.settingsLabel)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(~.saveAndNewGameButton, action: new)
                    }
                }
            }
        }
    }
}
//MARK: - Previews
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView.Settings(settings: .constant(AppState().settings), new: {})
    }
}
