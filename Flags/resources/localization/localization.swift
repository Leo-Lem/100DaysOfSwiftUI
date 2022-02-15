//
//  localization.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation
import SwiftUI
import MySwiftUI

//MARK: - translation values to make localization more robust
enum Translation {
    case titleLabel,
         historyLabel,
         settingsLabel,
         
         tapFlagLabel,
         scoreLabel(score: Int),
         roundsCountLabel(rounds: Int),
         flagsCountLabel(flags: Int),
         
         okButton,
         newGameButton,
         saveAndNewGameButton,
         
         answerAlertTitle(correct: Bool),
         answerAlertMessage(correct: Bool, score: Int? = nil, country: String? = nil),
         gameAlertTitle,
         gameAlertMessage(score: Int)
    
    var localized: LocalizedStringKey {
        switch self {
        case .titleLabel: return "title-label"
        case .historyLabel: return "history-label"
        case .settingsLabel: return "settings-label"
            
        case .tapFlagLabel: return "tapFlag-label"
        case .scoreLabel(let score): return "score-label \(score)"
        case .roundsCountLabel(let rounds): return "roundsCount-label \(rounds)"
        case .flagsCountLabel(let flags): return "flagsCount-label \(flags)"
            
        case .okButton: return "ok-button"
        case .newGameButton: return "newGame-button"
        case .saveAndNewGameButton: return "saveAndNewGame-button"
           
        case .answerAlertTitle(let correct):
            return correct ? "answer-alert-title-correct" : "answer-alert-title-wrong"
        case .answerAlertMessage(let correct, let score, let country):
            return correct ? "answer-alert-message-correct \(score!)" : "answer-alert-message-wrong \(country!)"
        case .gameAlertTitle:
            return "game-alert-title"
        case .gameAlertMessage(let score):
            return "game-alert-message \(score)"
        }
    }
}

prefix operator ~
prefix func ~ (translation: Translation) -> LocalizedStringKey { translation.localized }

//MARK: - localized country names
extension Country {
    var localized: String { self.rawValue~ }
}
