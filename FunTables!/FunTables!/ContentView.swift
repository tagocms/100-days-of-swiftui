//
//  ContentView.swift
//  FunTables!
//
//  Created by Tiago Camargo Maciel dos Santos on 16/05/25.
//

import SwiftUI

struct ContentView: View {
    private let names = [
        "chick",
        "bear",
        "buffalo",
        "chicken",
        "cow",
        "crocodile",
        "dog",
        "duck",
        "elephant",
        "frog",
        "giraffe",
        "goat",
        "gorilla",
        "hippo",
        "horse",
        "monkey",
        "moose",
        "narwhal"
    ]
    
    @State private var selectedIndex = 0
    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    @State private var scaled = false
    
    static private let title = "Fun Tables"
    static private let titleArray = Array(title)
    @State private var offset = CGSize.zero
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                
                LinearGradient(colors: [.yellow, .orange, .red], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                VStack {
                    Spacer()
                    HStack {
                        ForEach(0..<Self.titleArray.count, id: \.self) { index in
                            Text("\(Self.titleArray[index])")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                                .padding(5)
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 2))
                                .padding(-7)
                                .offset(offset)
                                .animation(.easeInOut.delay(Double(index) / 20.0), value: offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { offset = $0.translation }
                                        .onEnded { _ in
                                                offset = .zero
                                        }
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    Spacer()
                    
                
                    Image(names[selectedIndex])
                        .shadow(radius: 1)
                        .frame(width: 200, height: 200)
                        .transition(.push(from: .leading))
                        .id(selectedIndex)
                    
                    Spacer()
                    
                    NavigationLink(destination: Main()) {
                        Text("Multiply fun with us!")
                            .frame(maxWidth: 200, maxHeight: 40)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .background(.red)
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                            .scaleEffect(scaled ? 1.2 : 1)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: scaled)
                            .onAppear {
                                scaled.toggle()
                            }
                    }
                    
                    Spacer()
                }
                
            }
            .onReceive(timer) { _ in
                withAnimation {
                    selectedIndex = Int.random(in: 0..<names.count)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
