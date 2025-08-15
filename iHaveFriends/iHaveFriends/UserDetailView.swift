//
//  UserDetailView.swift
//  iHaveFriends
//
//  Created by Tiago Camargo Maciel dos Santos on 24/06/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Circle()
                
                Text(user.isActive ? "Active" : "Inactive")
            }
            .frame(height: 40)
            .font(.title)
            .foregroundStyle(user.isActive ? .green : .red)
            .padding(8)
            
            ScrollView {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Personal Information:")
                            .font(.largeTitle.bold())
                        
                        Text("Age: \(user.age)")
                        Text("Address: \(user.address)")
                        Text("Email: \(user.email)")
                        Text("Company: \(user.company)")
                    }
                    
                    Spacer()
                }
                .padding(8)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("About:")
                            .font(.largeTitle.bold())
                        
                        Text(user.about)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                }
                .padding(8)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Tags:")
                            .font(.largeTitle.bold())
                        
                        
                        ForEach(user.tags, id: \.self) { tag in
                            HStack {
                                Text(tag)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(8)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Friends:")
                            .font(.largeTitle.bold())
                        
                        
                        ForEach(user.friends) { friend in
                            HStack {
                                Text(friend.name)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(8)
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserDetailView(
        user: User(
            id: UUID(),
            isActive: true,
            name: "Tiago Camargo Maciel dos Santos",
            age: 24, company: "Grupo Boticário",
            email: "tagocms@gmail.com",
            address: "Rua Adelaide Stresser Scheleder, 135, Casa 13",
            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
            registered: .now,
            tags: [
                "Amigo",
                "Divertido",
                "Games",
                "Filmes"
            ],
            friends: [
                User.Friend(id: UUID(), name: "Joel da Silva"),
                User.Friend(id: UUID(), name: "Maria do Rosário"),
                User.Friend(id: UUID(), name: "Santana"),
                User.Friend(id: UUID(), name: "Santos Andrade")
            ])
        )
}
