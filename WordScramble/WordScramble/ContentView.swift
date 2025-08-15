//
//  ContentView.swift
//  WordScramble
//
//  Created by Tiago Camargo Maciel dos Santos on 08/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter a word", text: $newWord)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) {word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(word), \(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(alertTitle, isPresented: $showAlert) {
                
            } message: {
                Text(alertMessage)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Text("Score: \(score)")
                        
                        Button("Restart") {
                            restartGame()
                        }
                    }
                }
            }
        }
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var copy = rootWord
        
        for letter in word {
            guard let index = copy.firstIndex(of: letter) else {
                return false
            }
            copy.remove(at: index)
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isValid(word: String) -> Bool {
        if word == rootWord || word.count < 3 {
            return false
        } else {
            return true
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isReal(word: answer) else {
            showAlert(title: "Word doesn't exist", message: "You can't just make them up!")
            return
        }
        
        guard isValid(word: answer) else {
            showAlert(title: "Word is invalid", message: "Words cannot be shorter than 3 letters or equal to the current word.")
            return
        }
        
        guard isPossible(word: answer) else {
            showAlert(title: "Word not possible", message: "Word can't be created from '\(rootWord)'!")
            return
        }
        
        guard isOriginal(word: answer) else {
            showAlert(title: "Word already used", message: "Be more original!")
            return
        }
        
        withAnimation {
            score += answer.count
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        guard let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Unable to locate start.txt in bundle.")
        }
        
        guard let fileContents = try? String(contentsOf: fileURL, encoding: .ascii) else {
            fatalError("Unable to load start.txt from bundle")
        }
        
        let allWords = fileContents.components(separatedBy: "\n")
        
        rootWord = allWords.randomElement() ?? "silksong"
        return
    }
    
    func restartGame() {
        startGame()
        usedWords.removeAll()
        newWord = ""
        score = 0
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    ContentView()
}
