//
//  MissionView.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import SwiftUI
import MySwiftUI

struct MissionView: View {
    
    let mission: Mission
    
    @EnvironmentObject private var state: AppState
    var body: some View { Content(vm: ViewModel(state: state, mission: mission)) }
    
    struct Content: View {
        
        @StateObject var vm: ViewModel
        
        var body: some View {
            ScrollView(.vertical) {
                VStack {
                    MissionImage(vm.mission.image)
                        .padding(.top)
                    
                    Text(vm.mission.formattedLaunchDate, font: .headline)
                        .padding()
                    
                    Text(vm.mission.description)
                        .padding()
                    
                    Spacer(minLength: 25)
                    
                    ForEach(vm.crew, id: \.id) { astronaut in
                        let isCommander = astronaut.isCommanderOf(mission: vm.mission)
                        
                        NavigationLink(destination: AstronautView(astronaut: astronaut)) {
                            HStack {
                                Image(astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(.capsule)
                                    .overlay(
                                        Capsule()
                                            .stroke(
                                                isCommander ? Color.yellow: Color.primary,
                                                lineWidth: isCommander ? 5: 1
                                            )
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(astronaut.name, font: .body)
                                    Text(
                                        vm.mission.getRoleOf(astronaut: astronaut)?.formattedRole ?? "",
                                        color: .secondary
                                    )
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                    }
                }
            }
            .navigationBarTitle(vm.mission.formattedName, displayMode: .inline)
        }
    }
}

// MARK: - (Previews)
struct MissionView_Previews: PreviewProvider {
    
    static var previews: some View {
        MissionView(mission: .example)
    }
    
}
