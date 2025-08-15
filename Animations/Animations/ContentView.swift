//
//  ContentView.swift
//  Animations
//
//  Created by Tiago Camargo Maciel dos Santos on 13/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dragAmount = CGSize.zero
    @State private var isEnabled = false
    
    var body: some View {
            
        Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
        .frame(width: 150, height: 100)
        .clipShape(.rect(cornerRadius: 20))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation}
                .onEnded { pos in
                    withAnimation(.spring(duration: 1, bounce: 0.5)) {
                        dragAmount = .zero
                    }
                }
        )
        
        Spacer()
        ZStack {
            Rectangle()
                .fill(.indigo)
                .frame(width: 100, height: 100)
                .cornerRadius(20)
            
            if isEnabled {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                    .transition(.pivot)
                    .cornerRadius(20)
            }
        }
        Spacer()
        
        Button("Tap me!") {
            withAnimation {
                isEnabled.toggle()
            }
        }
            
            
    }
}

#Preview {
    ContentView()
}
