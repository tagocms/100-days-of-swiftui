//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Tiago Camargo Maciel dos Santos on 12/08/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Snow Seeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
