//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tiago Camargo Maciel dos Santos on 30/04/25.
//

import SwiftUI


struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

// Isso irá fazer com que seja criado um GridStack de 4 linhas e 4 colunas, cujo conteúdo de cada célula será a renderização de um texto que contém o número da linha e coluna daquela respectiva célula.
struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Text("R\(row) C\(col)")
        }
    }
}


#Preview {
    ContentView()
}
