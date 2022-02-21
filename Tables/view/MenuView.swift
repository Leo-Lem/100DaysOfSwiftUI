//
//  MenuView.swift
//  Tables
//
//  Created by Leopold Lemmermann on 20.02.22.
//

import SwiftUI
import MyStorage
import MySwiftUI

struct MenuView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        ZStack {
            Background().ignoresSafeArea()
            VStack {
                LogoView("Tables", systemImage: "xmark.square").foregroundColor(.black)
                
                Group {
                    if state.game != nil && state.game?.active ?? false {
                        Button("Continue") { state.screen = .game }
                            .menuButton()
                            .transition(.slide)
                    }
                    Button("New Game", action: newGame)
                        .menuButton()
                }
                .animation(.default.delay(1), value: state.game != nil && state.game?.active ?? false)
                
                gameView
                settingsView
                historyView
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Group {
                        Button(systemImage: "gear") { state.screen = .settings }
                        Button(systemImage: "list.bullet") { state.screen = .history }
                    }
                    .font(.title3.bold())
                    .foregroundColor(.black)
                }
            }
        }
        .navigationTitle("Return to Menu")
        .navigationBarHidden(true)
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
}

extension MenuView {
    
    private func newGame() {
        state.newGame()
        state.screen = .game
    }
    
}

extension MenuView {
    
    private var gameView: some View {
        let inGame = Binding<Bool>(get: { state.screen == .game }, set: { _ in state.screen = .menu })
        
        return NavigationLink(isActive: inGame) {
            GameView()
                .navigationTitle("Tables")
                .navigationBarTitleDisplayMode(.inline)
            } label: { EmptyView() }
    }
    
    private var settingsView: some View {
        let inSettings = Binding<Bool>(get: { state.screen == .settings }, set: { _ in state.screen = .menu })
        
        return VStack{}.sheet(isPresented: inSettings) {
            SettingsView()
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .embedInNavigation()
        }
    }
    
    private var historyView: some View {
        let inHistory = Binding<Bool>(get: { state.screen == .history }, set: { _ in state.screen = .menu })
        
        return VStack{}.sheet(isPresented: inHistory) {
            HistoryView()
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
                .embedInNavigation()
        }
    }
}

extension Settings.Operation {
    var symbol: String {
        switch self {
        case .add: return "+"
        case .sub: return "-"
        case .mul: return "x"
        case .pow: return "^"
        case .mod: return "%"
        }
    }
}

//MARK: - Previews
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(AppState())
    }
}
