//
//  ContentView.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import Combine
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showHistory = false
    @State private var numberOfDice: Int = 1
    @State private var numberOfSides = NumberOfSides.six
    @State private var diceRoll: DiceRoll? = nil
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>? = nil
    @State private var counter = 0
    
    var unwrappedTimer: Publishers.Autoconnect<Timer.TimerPublisher> {
        if let timer {
            return timer
        } else {
            let newTimer = Timer.publish(every: .greatestFiniteMagnitude, on: .main, in: .common).autoconnect()
            newTimer.upstream.connect().cancel()
            return newTimer
        }
    }
    
    let columns = [GridItem(.adaptive(minimum: 64, maximum: 80), alignment: .center)]
    let hapticsManager = HapticsManager.shared
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Form {
                    Section("Configuration") {
                        Picker("Number of dice", selection: $numberOfDice) {
                            ForEach(1...10, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        
                        Picker("Number of sides", selection: $numberOfSides) {
                            ForEach(NumberOfSides.allCases) {
                                Text("\($0.rawValue)")
                            }
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.2)
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<numberOfDice, id: \.self) { index in
                        ZStack(alignment: .center) {
                            switch numberOfSides {
                            case .four:
                                displayDie(shape: Triangle())
                            case .six:
                                displayDie(shape: Rectangle())
                            case .eight:
                                displayDie(shape: Hexagon())
                            case .ten:
                                displayDie(shape: Octagon())
                            case .twelve:
                                displayDie(shape: Decagon())
                            case .twenty:
                                displayDie(shape: Dodecagon())
                            case .hundred:
                                displayDie(shape: Circle())
                            }
                            
                            if let diceRoll {
                                if index < diceRoll.dice.count {
                                    Text("\(diceRoll.dice[index].numberThrownUnwrapped)")
                                        .font(counter < 30 ? .body : .body.bold())
                                }
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                if let diceRoll {
                    Button("Save Roll") {
                        modelContext.insert(diceRoll)
                        resetDice()
                        hapticsManager.play(.success)
                    }
                    .disabled(counter < 30 ? true : false)
                } else {
                    Button("Roll Dice!", action: startRoll)
                }
                
                Spacer()
            }
            .onAppear(perform: hapticsManager.prepareEngine)
            .onChange(of: numberOfDice, resetDice)
            .onChange(of: numberOfSides, resetDice)
            .onReceive(unwrappedTimer) { _ in
                if counter < 30 {
                    rollDice()
                } else {
                    timer?.upstream.connect().cancel()
                }
                
                counter += 1
            }
            .sheet(isPresented: $showHistory, content: HistoryView.init)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showHistory.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }

                }
            }
        }
    }
    
    func displayDie<S: Shape>(shape: S) -> some View {
        shape
            .fill(.secondary)
            .frame(width: 64, height: 64)
            .overlay(
                shape
                    .stroke(.primary, lineWidth: 1)
            )
    }
    
    func startRoll() {
        hapticsManager.play()
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        counter = 0
    }
    
    func rollDice() {
        var dice = [Die]()
        
        for _ in 0..<numberOfDice {
            let die = Die(numberSides: numberOfSides)
            die.rollDie()
            
            dice.append(die)
        }
        
        diceRoll = DiceRoll(dice: dice)
    }
    
    func resetDice() {
        diceRoll = nil
        counter = 0
    }
}

#Preview {
    ContentView()
}
