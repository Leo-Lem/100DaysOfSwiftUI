//
//  ContentView.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 02.08.21.
//

import SwiftUI
import MySwiftUI
import MyOthers

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Button(systemImage: "chevron.backward") { start(next: false) }
                Text(rootWord, font: .largeTitle.weight(.medium)).padding()
                Button(systemImage: "chevron.forward") { start(next: true) }
            }
            .foregroundColor(.primary)
            .font(.title)
            
            TextField("Enter your word", text: $newWord, onCommit: tryWord)
                .textFieldStyle(.roundedBorder)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .alert(
                    $error,
                    title: { $0.error(newWord).title },
                    actions: { _ in Button("OK", action: { newWord.removeAll() }) },
                    message: { Text($0.error(newWord).message) }
                )
            
            List(usedWords.reversed(), id: \.self) { word in
                Label(word, systemImage: "\(word.count).circle")
                    .accessibilityLabel("\(word), \(word.count) letters")
                    .foregroundColor(.primary)
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Text("Your score is \(score).", font: .headline)
            }
        }
    }
    
    @State private var error: ErrorKind? = nil
    @State private var newWord = ""
    @State private var rootID = Int.random(in: 0..<words.count)
    @State private var usedWords = [String]()
    
    private var rootWord: String { Self.words[rootID] }
    private var score: Int { usedWords.reduce(0, { $0 + $1.count }) }
}

extension Int {
    mutating func increase(_ max: Int) { self += self < max ? 1 : -max }
    mutating func decrease(_ min: Int) { self -= self > min ? 1 : -min }
}

extension ContentView {
    static let words: [String] = {
        guard
            let url = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let raw = try? String(contentsOf: url)
        else { fatalError("Could not load start.txt from bundle.") }
        
        return raw.components(separatedBy: "\n").shuffled()
    }()
    
    private func start(next: Bool) {
        self.usedWords.removeAll()
        next ? rootID.increase(Self.words.count) : rootID.decrease(0)
    }
    
    private func tryWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch answer {
        case _ where answer.count < 1: break
        case _ where answer.count < 3: self.error = .length
        case rootWord: self.error = .root
        case _ where usedWords.contains(answer): self.error = .used
        case _ where !rootWord.unorderedContains(answer): self.error = .illegal
        case _ where !isReal(answer): self.error = .unknown
        default:
            self.usedWords.append(newWord)
            self.newWord = ""
        }
    }
    
    private func isReal(_ word: String) -> Bool {
        let range = NSRange(location: 0, length: word.utf16.count),
            misspelledRange = UITextChecker().rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}

extension ContentView {
    enum ErrorKind {
        case length, root, used, illegal, unknown
        
        func error(_ word: String) -> (title: String, message: String) {
            switch self {
            case .root: return ("'\(word)' is start word...", "Obviously you can't just use the original word")
            case .length: return ("'\(word)' is too short...", "Only words with more than 2 letters allowed")
            case .used: return ("'\(word)' was used already...", "Be more original...")
            case .illegal: return ("'\(word)' not recognized...", "You can't just make them up, you know!")
            case .unknown: return ("'\(word)' not possible...", "That isn't an english word!")
            }
        }
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
