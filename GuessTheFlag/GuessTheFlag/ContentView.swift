//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tiago Camargo Maciel dos Santos on 25/04/25.
//

import SwiftUI

struct FlagImage: View {
    let flagName: String
    
    var body: some View {
        Image(flagName)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    private let questionsTotal = 8
    @State private var questionsAnswered = 0
    @State private var showingFinalScore = false
    
    @State private var degrees: [Double] = [0, 0, 0]
    @State private var flagPressed: [Bool] = [false, false, false]
    @State private var roundOn = true

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.7), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.2, blue: 0.1), location: 0.3)
                    
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    
                    VStack (spacing: 30) {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { index in
                            Button {
                                flagTapped(index: index)
                                withAnimation {
                                    flagPressed[index] = true
                                    degrees[index] += 360
                                    roundOn = false
                                }
                            } label: {
                                FlagImage(flagName: countries[index])
                                    .rotation3DEffect(
                                        .degrees(degrees[index]),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                    .opacity(
                                        roundOn ?
                                        1 :
                                        flagOpacity(flagPressed[index])
                                    )
                                    .scaleEffect(
                                        roundOn ?
                                        1 :
                                        flagScale(flagPressed[index])
                                    )
                                    .animation(.default, value: roundOn)
                            }
                            .accessibilityLabel(labels[countries[index]] ?? "Unknown Flag")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title3.bold())
                    Text("Questions answered: \(questionsAnswered)/\(questionsTotal)")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("\(scoreMessage). \nYour score is \(score).")
            }
            .alert("Ending", isPresented: $showingFinalScore) {
                Button("Restart", action: resetGame)
                Button("Return Home") {
                    dismiss()
                }
            } message: {
                Text("Your final score is \(score)!\nTap Restart to play again.")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func flagScale(_ pressed: Bool) -> Double {
        return pressed ? 1 : 0.8
    }
    
    func flagOpacity(_ pressed: Bool) -> Double {
        return pressed ? 1 : 0.25
    }
    
    func flagTapped(index: Int) {
        if index == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
            score -= 1
        }
        
        scoreMessage = "That's the flag of \(countries[index])"
        showingScore = true
        questionsAnswered += 1
    }
    
    func askQuestion() {
        if questionsAnswered >= 8 {
            showingFinalScore = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            flagPressed = [false, false ,false]
            roundOn = true
        }
    }
    
    func resetGame() {
        scoreTitle = ""
        scoreMessage = ""
        score = 0
        questionsAnswered = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
