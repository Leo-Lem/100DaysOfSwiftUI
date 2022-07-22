//
//  AstronautVM.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import Foundation

extension AstronautView {
    @MainActor final class ViewModel: ObservableObject {
        
        private let state: AppState
        init(
            state: AppState,
            astronaut: Astronaut
        ) {
            self.state = state
            self.astronaut = astronaut
            self.missions = state.missions.getMissionsFor(astronaut: astronaut)
        }
        
        let astronaut: Astronaut,
            missions: [Mission]
        
    }
}
