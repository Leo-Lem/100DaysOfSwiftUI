//
//  MissionVM.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import Foundation

extension MissionView {
    
    @MainActor final class ViewModel: ObservableObject {
        
        private let state: AppState
        init(state: AppState, mission: Mission) {
            self.state = state
            self.mission = mission
            
            self.crew = mission.crew.map { member in
                guard let astronaut = state.astronauts.getAstronautFor(id: member.id) else {
                    fatalError("missing \(member)")
                }
                
                return astronaut
            }
        }
        
        let mission: Mission,
            crew: [Astronaut]
        
    }
    
}
