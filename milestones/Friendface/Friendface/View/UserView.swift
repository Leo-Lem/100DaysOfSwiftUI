//
//  DetailView.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 21.11.21.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        VStack {
            Group {
                Text(user.wrappedEmail)
                Text(user.wrappedAddress)
            }
            .font(.subheadline)
            
            List {
                Section("About") {
                    AboutView(about: user.wrappedAbout)
                }
                Section("Friends") {
                    FriendsView(friends: user.friendsArray)
                }
                Section("Tags") {
                    TagsView(user: user)
                }
            }
            .navigationTitle("\(user.wrappedName) (\(user.age)) at \(user.wrappedCompany)")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
            Text("joined on \(user.wrappedRegistered.formatted())")
            Text("ID: \(user.wrappedId)")
        }
    }
}
