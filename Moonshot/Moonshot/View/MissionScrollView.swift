//
//  MissionScrollView.swift
//  Moonshot
//
//  Created by Tiago Camargo Maciel dos Santos on 27/05/25.
//

import SwiftUI

struct MissionScrollView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.rect(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12).strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(member.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(member.role)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(member.astronaut.name)
                        .accessibilityHint(member.role)
                    }
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    MissionScrollView(
        mission: missions[1],
        crew: [
            .init(
                role: "Commander",
                astronaut: .init(
                    id: "armstrong",
                    name: "Neil Armstrong",
                    description: "Astronaut"
                )
            )
        ]
    )
    .preferredColorScheme(.dark)
}
