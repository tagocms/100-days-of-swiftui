//
//  Settings.swift
//  FunTables!
//
//  Created by Tiago Camargo Maciel dos Santos on 19/05/25.
//

import SwiftUI

struct Settings: View {
    @State private var numberOfQuestions: Int
    @State private var minimumNumber: Int
    @State private var maximumNumber: Int
    @State private var alternativeNumber: Int
    
    private let closure: ((Int, Int, Int, Int) -> Void)?
    
    init(numberOfQuestions: Int, minimumNumber: Int, maximumNumber: Int, alternativeNumber: Int, _ closure: ((Int, Int, Int, Int) -> Void)? = nil) {
        self.numberOfQuestions = numberOfQuestions
        self.minimumNumber = minimumNumber
        self.maximumNumber = maximumNumber
        self.alternativeNumber = alternativeNumber
        self.closure = closure
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Options") {
                    Stepper(value: $numberOfQuestions, in: 1...20) {
                        Text("Number of questions: \(numberOfQuestions)")
                    }
                    .onChange(of: numberOfQuestions) { _, __ in
                        passData()
                    }
                    
                    Stepper(value: $minimumNumber, in: 1...6) {
                        Text("Minimum Number: \(minimumNumber)")
                    }
                    .onChange(of: minimumNumber) { _, __ in
                        passData()
                    }
                    
                    Stepper(value: $maximumNumber, in: 7...12) {
                        Text("Maximum Number: \(maximumNumber)")
                    }
                    .onChange(of: maximumNumber) { _, __ in
                        passData()
                    }
                    
                    Stepper(value: $alternativeNumber, in: 2...6) {
                        Text("Number of Alternatives: \(alternativeNumber)")
                    }
                    .onChange(of: alternativeNumber) { _, __ in
                        passData()
                    }
                }
                
            }
            .scrollContentBackground(.hidden)
            .background {
                Color.yellow
                    .ignoresSafeArea()
                
                LinearGradient(colors: [.yellow, .orange, .red], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                    .opacity(0.5)
            }
        }
        .navigationTitle("Settings")
    }
    
    func passData() {
        print("Dados estão sendo passados para o GameView!")
        closure?(numberOfQuestions, minimumNumber, maximumNumber, alternativeNumber)
    }
}

#Preview {
    Settings(
        numberOfQuestions: 10,
        minimumNumber: 1,
        maximumNumber: 10,
        alternativeNumber: 4
    )
}
