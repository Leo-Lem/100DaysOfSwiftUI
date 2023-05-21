//
//  AstronautView.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 20.08.21.
//

import SwiftUI
import MySwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    @EnvironmentObject private var state: AppState
    var body: some View { Content(vm: ViewModel(state: state, astronaut: astronaut)) }
    
    struct Content: View {
        
        @StateObject var vm: ViewModel
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Image(vm.astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                        
                        HStack(spacing: 50) {
                            ForEach(vm.missions, id: \.id) { mission in
                                NavigationLink(destination: MissionView(mission: mission)) {
                                    MissionImage(mission.image, isIcon: true)
                                    Text("\(mission.id)", font: .headline)
                                }
                            }
                        }
                        
                        Text(vm.astronaut.description).padding()
                    }
                }
            }
            .navigationBarTitle(vm.astronaut.name, displayMode: .inline)
        }
        
    }
}

// MARK: - (Previews)
struct AstronautView_Previews: PreviewProvider {
    
    static var previews: some View {
        AstronautView(astronaut: .example)
            .environmentObject(AppState())
    }
    
}
