//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(systemImage: "list.bullet.circle", true: $history)
                    .font(size: 30)
                Text("Guess the Flag", font: .largeTitle.bold()).padding()
                Button(systemImage: "gear.circle", true: $settings)
                    .font(size: 30)
            }
            .foregroundColor(.white)
            
            RoundView(round: game.round, tryCountry: state.try, newRound: state.newRound)
                .padding()
            
            Spacer()
            Spacer()
            
            Text("Score: \(game.score)", font: .title.bold(), color: .white)
                .alert("Game!", isPresented: finished) {
                    Button("Start New Game") {}
                } message: {
                    Text("You scored \(game.score) point(s)!")
                }
            
            Spacer()
        }
        .group { $0
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                .radialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
            )
            .ignoresSafeArea()
        }
        .group { $0
            .sheet(isPresented: $history) { HistoryView(games: state.games) }
            .sheet(isPresented: $settings) {
                SettingsView(settings: $state.settings) {
                    settings = false
                    state.newGame(save: false)
                }
            }
        }
    }
    
    @State private var answer: Country? = nil
    private var finished: Binding<Bool> { Binding(get: {!game.active}, set: {_ in state.newGame()} ) }
    
    @State private var history = false
    @State private var settings = false
    
    var game: Game { state.game }
    @StateObject private var state = AppState()
}


#if DEBUG
//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
