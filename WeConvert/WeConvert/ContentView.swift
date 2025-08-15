//
//  ContentView.swift
//  WeConvert
//
//  Created by Tiago Camargo Maciel dos Santos on 24/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit: Units = .miligram
    @State private var input: Double = 0.0
    
    @State private var outputUnit: Units = .miligram
    private var output: Double {
        convert()
    }
    
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Unit and Value") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Value", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                }
                
                Section("Output Unit and Value") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("\(output, format: .number)")
                }
            }
            .navigationTitle("We Convert")
            .toolbar {
                if valueIsFocused {
                    Button("Done") {
                        valueIsFocused.toggle()
                    }
                }
            }
        }
    }
    
    private func convert() -> Double {
        let inputInMiligram = convertToMiligram(input: input, inputUnit: inputUnit)
        let outputInUnit = convertFromMiligram(inputInMiligram: inputInMiligram, outputUnit: outputUnit)
        return outputInUnit
    }
    
    private func convertToMiligram(input: Double, inputUnit: Units) -> Double {
        switch inputUnit {
        case .miligram:
            input
        case .gram:
            1000 * input
        case .kilogram:
            1000000 * input
        case .ounce:
            28349.523125 * input
        case .pound:
            453592.37 * input
        }
    }
    
    private func convertFromMiligram(inputInMiligram: Double, outputUnit: Units) -> Double {
        switch outputUnit {
        case .miligram:
            inputInMiligram
        case .gram:
            inputInMiligram / 1000
        case .kilogram:
            inputInMiligram / 1000000
        case .ounce:
            inputInMiligram / 28349.523125
        case .pound:
            inputInMiligram / 453592.37
        }
    }
}

#Preview {
    ContentView()
}
