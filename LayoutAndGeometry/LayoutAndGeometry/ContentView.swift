//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tiago Camargo Maciel dos Santos on 05/08/25.
//

import SwiftUI


struct ContentView: View {
    let colors: [Color] = [
        .red,
        .green,
        .blue,
        .orange,
        .pink,
        .purple,
        .yellow
    ]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<100) { index in
                    GeometryReader { proxy in
                        let proxyMinY = proxy.frame(in: .global).minY
                        let proxyMaxY = proxy.frame(in: .global).maxY
                        let proxyMidY = proxy.frame(in: .global).midY
                        let minY = fullView.frame(in: .global).minY
                        let maxY = fullView.frame(in: .global).maxY
                        let midY = fullView.frame(in: .global).midY
                        let opacity = max(0, min(proxyMinY / (minY + 200), 1))
                        let scale: CGFloat = max(min(1.2 - ((maxY - proxyMaxY) / maxY), 1), 0.5)
                        let hue: Double = max(0, min(abs(proxyMidY - midY) / (midY), 1))
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: hue, saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity)
                            .scaleEffect(scale)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

