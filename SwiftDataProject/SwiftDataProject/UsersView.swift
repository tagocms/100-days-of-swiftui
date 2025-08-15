//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Tiago Camargo Maciel dos Santos on 17/06/25.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                Spacer()
                Text("Job count: \(user.unwrappedJobs.count)")
                    .padding(8)
                    .background(.blue)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    
            }
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
