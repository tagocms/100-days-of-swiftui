//
//  MainGridView.swift
//  Moonshot
//
//  Created by Tiago Camargo Maciel dos Santos on 27/05/25.
//

import SwiftUI

struct MainGridView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
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
                
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [ GridItem(.adaptive(minimum: 150))]
    
    MainGridView(astronauts: astronauts, missions: missions, columns: columns)
        .preferredColorScheme(.dark)
}
