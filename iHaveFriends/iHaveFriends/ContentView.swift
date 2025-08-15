//
//  ContentView.swift
//  iHaveFriends
//
//  Created by Tiago Camargo Maciel dos Santos on 24/06/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \User.name) var users: [User]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name)
                        Spacer()
                        Text(user.isActive ? "Active" : "Inactive")
                            .foregroundStyle(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .navigationTitle("iHaveFriends")
            .onAppear {
                Task {
                    if users.isEmpty {
                        let usersBuffer = await fetchUserData()
                        
                        for user in usersBuffer {
                            modelContext.insert(user)
                        }
                    }
                }
            }
        }
    }
    
    func fetchUserData() async -> [User] {
        let urlString = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: urlString)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedData = try? decoder.decode([User].self, from: data) {
                for user in decodedData {
                    print(user.name)
                }
                return decodedData
            }
        } catch {
            print("Invalid response.")
        }
        
        return []
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
