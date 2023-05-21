//
//  FacilitiesView.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import SwiftUI
import MySwiftUI
import CoreMIDI

extension ResortView {
    struct Facilities: View {
        let facilities: [Facility]
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    Spacer(minLength: 10)
                    
                    ForEach(facilities, id: \.self) { facility in
                        Button(true: $alert) {
                            Label(facility.rawValue, systemImage: facility.icon)
                                .padding(10)
                                .cornerRadius(5, border: (.black, 2))
                                .foregroundColor(.primary)
                        }
                        .alert(facility.rawValue, isPresented: $alert, actions: {}) {
                            Text(facility.description)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        
        @State private var selectedFacility: Facility?
        @State private var alert = false
    }
}

extension Facility {
    var icon: String {
        switch self {
        case .accomodation: return "house"
        case .beginners: return "1.circle"
        case .crossCountry: return "map"
        case .ecoFriendly: return "leaf.arrow.circlepath"
        case .family: return "person.3"
        }
    }
    
    var description: String {
        switch self {
        case .accomodation: return "This resort has popular on-site accommodation."
        case .beginners: return "This resort has lots of ski schools."
        case .crossCountry: return "This resort has many cross-country ski routes."
        case .ecoFriendly: return "This resort has won an award for environmental friendliness."
        case .family: return "This resort is popular with families."
        }
    }
}

//MARK: - Previews
struct FacilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView.Facilities(facilities: Resort.example.facilitiesObjects)
    }
}
