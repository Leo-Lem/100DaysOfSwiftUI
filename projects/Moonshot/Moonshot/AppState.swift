//
//  AppState.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 21.07.22.
//

import Foundation

final class AppState: ObservableObject {
    
    let astronauts: [Astronaut],
        missions: [Mission]
    
    init() {
        do {
            astronauts = try Self.bundle.load(Self.filename.astronauts)
            missions = try Self.bundle.load(Self.filename.missions)
        } catch {
            fatalError("failed to load astronauts/missions from Bundle: \(error)")
        }
    }
    
    private static let bundle: Bundle = .main
    private static let filename: (astronauts: String, missions: String) = ("astronauts.json", "missions.json")
    
}
