//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tiago Camargo Maciel dos Santos on 25/04/25.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

struct Menu: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.1, green: 0.2, blue: 0.7)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Guess the Flag")
                        .prominentTitle()
                    NavigationLink {
                        ContentView()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 0.76, green: 0.2, blue: 0.1))
                                .frame(width: 200, height: 50)
                                .cornerRadius(25)
                            
                            Text("Play")
                                .font(.headline.bold())
                                .foregroundStyle(.white)
                                .clipShape(.rect)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Menu()
}
