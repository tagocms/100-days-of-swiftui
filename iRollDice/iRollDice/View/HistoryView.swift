//
//  HistoryView.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import SwiftData
import SwiftUI


struct HistoryView: View {
    @Query(sort: \DiceRoll.date, order: .reverse) private var diceRolls: [DiceRoll]
    
    var body: some View {
        List(diceRolls) { diceRoll in
            GeometryReader { proxy in
                HStack(alignment: .center) {
                        Text("\(diceRoll.dice.count)d\(diceRoll.dice[0].numberOfSides.rawValue)")
                        .font(.title2.bold())
                            .frame(width: proxy.size.width * 0.3, alignment: .trailing)
                        VStack(alignment: .leading) {
                            Text("Total result: \(diceRoll.totalThrown)")
                                .font(.headline)
                            Text(diceRoll.formattedDate)
                                .font(.subheadline)
                        }
                }
            }
            .frame(height: 40)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: DiceRoll.self, configurations: config)
        let exampleRoll = DiceRoll(dice: [.init(numberSides: .twenty), .init(numberSides: .twenty)])
        container.mainContext.insert(exampleRoll)
        return HistoryView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
