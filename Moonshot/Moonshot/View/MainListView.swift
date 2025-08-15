//
//  MainListView.swift
//  Moonshot
//
//  Created by Tiago Camargo Maciel dos Santos on 27/05/25.
//

import SwiftUI

struct MainListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(mission.displayName)
                    .accessibilityHint("Launch date: \(mission.formattedLaunchDate)")
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.darkBackground)
        }
        .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    MainListView(astronauts: astronauts, missions: missions)
        .preferredColorScheme(.dark)
}
