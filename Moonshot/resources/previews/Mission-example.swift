//
//  previews-Mission.swift
//  Moonshot
//
//  Created by Leopold Lemmermann on 22.07.22.
//

import Foundation

extension Mission {
    
    static let example = Mission(
        id: 7,
        launchDate: try? Date("1968-10-11", strategy: .dateTime),
        crew: [
            CrewMember(id: "schirra", role: .commander),
            CrewMember(id: "eisele", role: .commandModulePilot),
            CrewMember(id: "cunningham", role: .lunarModulePilot)
        ],
        description: "Apollo 7 was an October 1968 human spaceflight mission carried out by the United States. It was the first mission in the United States' Apollo program to carry a crew into space. It was also the first U.S. spaceflight to carry astronauts since the flight of Gemini XII in November 1966.\n\nThe AS-204 mission, also known as \"Apollo 1\", was intended to be the first crewed flight of the Apollo program. It was scheduled to launch in February 1967, but a fire in the cabin during a January 1967 test killed the crew.\n\nCrewed flights were then suspended for 21 months, while the cause of the accident was investigated and improvements made to the spacecraft and safety procedures, and uncrewed test flights of the Saturn V rocket and Apollo Lunar Module were made. Apollo 7 fulfilled Apollo 1's mission of testing the Apollo command and service module (CSM) in low Earth orbit." // swiftlint:disable:this line_length
    )
}
