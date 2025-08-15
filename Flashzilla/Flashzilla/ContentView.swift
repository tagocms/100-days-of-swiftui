//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tiago Camargo Maciel dos Santos on 28/07/25.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @State private var cards = [Card]()
    @State private var tryAgain = [Card]()
    @State private var isActive = true
    @State private var timeRemaining = 100
    @State private var isShowingEditScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card) { classification in
                            withAnimation {
                                checkAnswer(classification: classification, index: firstIndexOf(card))
                            }
                        }
                        .stacked(at: firstIndexOf(card), in: cards.count)
                        .allowsHitTesting(firstIndexOf(card) == cards.count - 1)
                        .accessibilityHidden(firstIndexOf(card) < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty || timeRemaining == 0 {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        isShowingEditScreen.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                checkAnswer(classification: .wrong, index: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                checkAnswer(classification: .right, index: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                }
            }
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $isShowingEditScreen, onDismiss: resetCards, content: EditCardsView.init)
        .onAppear(perform: resetCards)
    }
    
    func checkAnswer(classification: Classification, index: Int) {
        guard index >= 0 else { return }
        let card = cards[index]
        
        if classification == .right {
            removeCard(at: index)
        } else {
            tryAgain.insert(card, at: 0)
            removeCard(at: index)
        }
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
        
        if cards.isEmpty {
            cards = tryAgain
            tryAgain = []
            if cards.isEmpty {
                isActive = false
            }
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        tryAgain = []
        cards = Card.loadFromDocumentsDirectory(fileName: "Cards")
    }
    
    func firstIndexOf(_ card: Card) -> Int {
        if let index = cards.firstIndex(of: card) {
            return index
        }
        
        return 0
    }
}

#Preview {
    ContentView()
}
