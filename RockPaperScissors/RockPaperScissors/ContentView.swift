//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tiago Camargo Maciel dos Santos on 02/05/25.
//

import SwiftUI

struct TextState: View {
    let state: Bool
    let textTrue: String
    let textFalse: String
    
    var body: some View {
        Text(state ? textTrue : textFalse)
            .foregroundStyle(state ? .green : .red)
            .font(.largeTitle.bold())
    }
}

struct ContentView: View {
    private let options = ["🪨", "📃", "✂️"]
    private let totalRounds = 10
    
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var playerAction = Bool.random()
    @State private var playerScored = false
    @State private var playerChoice = 0
    @State private var scoreDelta = 0
    
    @State private var score = 0 {
        didSet {
            if score > oldValue {
                playerScored = true
                scoreDelta = 1
            } else if score < oldValue {
                playerScored = false
                scoreDelta = -1
            } else {
                playerScored = false
                scoreDelta = 0
            }
        }
    }
    @State private var roundCount = 1
    @State private var showingEnding = false
    @State private var showingComputerChoice = false
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: .secondary, location: 0),
                .init(color: .secondary, location: 0.25),
                .init(color: .clear, location: 0.5),
                .init(color: .secondary, location: 0.75),
                .init(color: .secondary, location: 1),
            ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                if !showingComputerChoice {
                    Spacer()
                    
                    Text("Your opponent asks you to")
                        .font(.headline)
                    TextState(state: playerAction, textTrue: "Win", textFalse: "Lose")
                    Spacer()
                    
                    Text("Choose your move")
                        .font(.headline)
                    HStack {
                        ForEach(0..<options.count) { i in
                            Button {
                                handleChoice(index: i)
                            } label: {
                                Text(options[i])
                                    .font(.system(size: 100))
                            }
                        }
                    }
                    
                    Spacer()
                        

                } else {
                    Spacer()
                    Text("You")
                        .font(.headline)
                    HStack {
                        TextState(state: playerScored, textTrue: "Scored \(scoreDelta) point!", textFalse: "Lost \(scoreDelta) point!")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Your opponent asked you to")
                            .font(.headline)
                        Text(playerAction ? "Win" : "Lose")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    
                    Text("You chose")
                        .font(.headline)
                    Text("\(options[playerChoice])")
                        .font(.system(size: 100))
                    
                    Text("Your opponent chose")
                        .font(.headline)
                    Text("\(options[computerChoice])")
                        .font(.system(size: 100))
                    
                    Button {
                        nextRound()
                    } label: {
                        Text("Next Round")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .frame(width: 200, height: 50)
                            .background(.thinMaterial)
                            .clipShape(Capsule())
                        
                    }
                    
                    Spacer()
                }
                    
                
                Spacer()
                
                
                Text("Round: \(roundCount)/10")
                    .font(.subheadline)
                Text("Score: \(score)")
                    .font(.headline)
            }
            .frame(width: 400, height: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
        .alert("Game Over", isPresented: $showingEnding) {
            Button("Restart") {
                resetGame()
            }
        } message: {
            Text("Your score is \(score)/\(totalRounds)")
        }
    }
    
    func nextRound() {
        if roundCount == 10 {
            showingEnding.toggle()
        } else {
            computerChoice = Int.random(in: 0..<3)
            playerAction.toggle()
            showingComputerChoice.toggle()
            roundCount += 1
        }
    }
    
    func handleChoice(index: Int) {
        if playerAction {
            if computerChoice == 0 {
                if index == 1 {
                    score += 1
                } else if index == 2 {
                    score -= 1
                } else {
                    score += 0
                }
            } else if computerChoice == 1 {
                if index == 0 {
                    score -= 1
                } else if index == 2 {
                    score += 1
                } else {
                    score += 0
                }
            } else {
                if index == 0 {
                    score += 1
                } else if index == 1 {
                    score -= 1
                } else {
                    score += 0
                }
            }
        } else {
            if computerChoice == 0 {
                if index == 1 {
                    score -= 1
                } else if index == 2 {
                    score += 1
                } else {
                    score += 0
                }
            } else if computerChoice == 1 {
                if index == 0 {
                    score += 1
                } else if index == 2 {
                    score -= 1
                } else {
                    score += 0
                }
            } else {
                if index == 0 {
                    score -= 1
                } else if index == 1 {
                    score += 1
                } else {
                    score += 0
                }
            }
        }
        
        playerChoice = index
        
        showingComputerChoice.toggle()
        
    }
    
    func resetGame() {
        roundCount = 1
        score = 0
        showingComputerChoice = false
        computerChoice = Int.random(in: 0..<3)
        playerAction = Bool.random()
    }
}

#Preview {
    ContentView()
}
