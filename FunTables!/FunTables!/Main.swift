//
//  Main.swift
//  FunTables!
//
//  Created by Tiago Camargo Maciel dos Santos on 16/05/25.
//

import SwiftUI

struct Main: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var score = 0
    @State private var currentQuestion = 0
    
    @State private var numberOfQuestions = 10
    @State private var minimumNumber = 1
    @State private var maximumNumber = 10
    @State private var alternativeNumber = 4
    
    @State private var expression = ""
    @State private var answer = 0
    @State private var options = [Int]()
    @State private var scaled = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var endingTitle = "The End"
    @State private var endingMessage = ""
    @State private var showingEnding = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                
                LinearGradient(colors: [.yellow, .orange, .red], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                VStack {
                    Spacer()
                    
                    VStack {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Question \(currentQuestion)")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.blue)
                            
                            Text("\(expression)")
                                .font(.largeTitle)
                                .padding(.bottom, 20)
                        }
                        
                        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                            ForEach (0..<options.count, id: \.self) { id in
                                Button {
                                    nextQuestion(choice: id)
                                } label: {
                                    Text("\(options[id])")
                                        .font(.title)
                                        .frame(width: 80, height: 30)
                                        .padding()
                                        .background(.red)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundStyle(.white)
                                        .scaleEffect(scaled ? 1.2 : 1)
                                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: scaled)
                                }
                            }
                        }
                        .onAppear {
                            scaled.toggle()
                        }
                        .padding(.horizontal, 50)
                        
                    }
                    .animation(.easeInOut(duration: 1), value: currentQuestion)
                    
                    Spacer()
                    Text("Score: \(score)")
                        .font(.headline)
                    Text("Current question: \(currentQuestion)/\(numberOfQuestions)")
                        .font(.headline)
                }
            }
            .alert("\(alertTitle)", isPresented: $showingAlert) {
                Button { }
                label: {
                    Text("OK")
                }
            } message: {
                Text("\(alertMessage)")
            }
            .alert("\(endingTitle)", isPresented: $showingEnding) {
                Button {
                    resetGame()
                }
                label: {
                    Text("Play Again")
                }
                
                Button {
                    dismiss()
                }
                label: {
                    Text("Go to Menu")
                }
            } message: {
                Text("\(endingMessage)")
            }
        }
        .onAppear {
            resetGame()
        }
        .navigationTitle("Fun Tables!")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink {
                    Settings(
                        numberOfQuestions: numberOfQuestions,
                        minimumNumber: minimumNumber,
                        maximumNumber: maximumNumber,
                        alternativeNumber: alternativeNumber
                    ) { numberOfQuestions, minimumNumber, maximumNumber, alternativeNumber in
                        self.numberOfQuestions = numberOfQuestions
                        self.minimumNumber = minimumNumber
                        self.maximumNumber = maximumNumber
                        self.alternativeNumber = alternativeNumber
                    }
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
            }
        }
    }
    
    func startGame() {
        options.removeAll()
        
        let first = Int.random(in: minimumNumber...maximumNumber)
        let second = Int.random(in: minimumNumber...maximumNumber)
        
        self.expression = "\(first) x \(second) = ?"
        self.answer = first * second
        let answerNumber = Int.random(in: 0..<alternativeNumber)
        
        for i in 0..<alternativeNumber {
            if i == answerNumber {
                options.append(answer)
            } else {
                let option = answer - Int.random(in: 1...10)
                let oppositeOption = option * -1 == answer ? option + Int.random(in: 1...10) : option * -1
                options.append(max(option, oppositeOption))
            }
        }
        
        currentQuestion += 1
    }
    
    func nextQuestion(choice: Int) {
        if options[choice] == answer {
            score += 1
            alertTitle = "Correct, good job!"
            alertMessage = "Your score is now \(score) points."
        } else {
            alertTitle = "Better luck next time!"
            alertMessage = "\(expression)".replacingCharacters(in: expression.range(of: "?")!, with: "\(answer)")
        }
        
        showingAlert = true
        
        if currentQuestion < numberOfQuestions {
            startGame()
        } else {
            endingMessage = "Your score is \(score) points. Play again?"
            showingEnding = true
            
        }
        
    }
    
    func resetGame() {
        score = 0
        currentQuestion = 0
        showingAlert = false
        startGame()
    }
}

#Preview {
    Main()
}
