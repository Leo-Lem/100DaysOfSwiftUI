//
//  ContentView.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 02.08.21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    //error messages
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(word), \(word.count) letters")
                }
                
                Text("Your score is \(score)")
                    .padding()
                    .font(.headline)
            }
            .onAppear(perform: startGame)
            .navigationTitle(rootWord)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: startGame) { Text("New Game") }
                }
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func startGame() {
        usedWords = [String](); score = 0
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Word is start word", message: "Obviously you can't just use the original word")
            return
        }
        
        guard answer.count > 2 else {
            wordError(title: "Word is too short", message: "Only words with more than 2 letters allowed")
            return
        }
        
        guard isOriginal(answer) else {
            wordError(title: "Word used already", message: "Be more original...")
            return
        }
        
        guard isPossible(answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(answer) else {
            wordError(title: "Word not possible", message: "That isn't an english word!")
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += answer.count
        newWord = ""
    }
    
    private func isOriginal(_ word: String) -> Bool { !usedWords.contains(word) }
    
    private func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
