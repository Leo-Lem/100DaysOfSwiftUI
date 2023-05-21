//
//  MissionView.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 20.08.21.
//

import SwiftUI
import MyData
import MySwiftUI

struct MissionsView: View {
    
    @EnvironmentObject private var state: AppState
    
    var body: some View {
        NavigationView {
            List(state.missions) { mission in
                NavigationLink(destination: MissionView(mission: mission)) {
                    MissionImage(mission.image, isIcon: true)
                    
                    VStack(alignment: .leading) {
                        Text(mission.formattedName, font: .headline)
                        
                        Text(displayingCrew ? mission.formattedCrewNames : mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle(~.appTitle)
            .navigationBarItems(
                trailing: Button(
                    displayingCrew ? ~.displayDate : ~.displayCrew, primitiveAction: .toggle($displayingCrew)
                )
            )
        }
    }
    
    @State private var displayingCrew = false
    
}

// MARK: - (Previews)
struct MissionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MissionsView()
            .environmentObject(AppState())
    }
    
}
