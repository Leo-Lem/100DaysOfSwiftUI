//
//  HistoryView.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MySwiftUI

struct HistoryView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        //TODO: Redesign this to make it look nicer
        if state.history.isEmpty { Text("Nothing to see here yet...") }
        
        List(state.history) { game in
            VStack {
                HStack {
                    Text("scored \(game.score) / \(game.maxScore)", font: .headline)
                    Spacer()
                    Text(game.timestamp, format: .dateTime, font: .caption.bold())
                }
                .padding(.top, 5)
                
                ReviewView(game: game)
            }
        }
    }
}

//MARK: - Previews
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(AppState())
            .embedInNavigation()
    }
}
