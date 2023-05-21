//
//  FriendsView.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 21.11.21.
//

import SwiftUI

struct FriendsView: View {
    let friends: [User]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(friends) { friend in
                    NavigationLink(getInitials(for: friend.wrappedName)) {
                        UserView(user: friend)
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(Circle().stroke())
                }
            }
            .padding(.vertical)
        }
    }
}
