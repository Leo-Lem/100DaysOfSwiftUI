//
//  FlagsView.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import SwiftUI
import MySwiftUI

struct FlagsView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(systemImage: "list.bullet.circle", true: $history)
                    .font(size: 30)
                    .padding()
                Spacer()
                Text(~.titleLabel, font: .largeTitle.bold()).padding()
                Spacer()
                Button(systemImage: "gear.circle", true: $settings)
                    .font(size: 30)
                    .padding()
            }
            .foregroundColor(.white)
            
            Round(round: game.round, tryCountry: state.try, newRound: state.newRound)
                .padding()
            
            Spacer()
            Spacer()
            
            Text(~.scoreLabel(score: game.score), font: .title.bold(), color: .white)
                .alert(~.gameAlertTitle, isPresented: finished) {
                    Button(~.newGameButton) {}
                } message: {
                    Text(~.gameAlertMessage(score: game.score))
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
            .sheet(isPresented: $history) { History(games: state.games) }
            .sheet(isPresented: $settings) {
                Settings(settings: $state.settings) {
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

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView()
    }
}
