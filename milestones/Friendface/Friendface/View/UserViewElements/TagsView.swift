//
//  TagsView.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 21.11.21.
//

import SwiftUI

struct TagsView: View {
    let user: User
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(user.wrappedTags, id: \.self) { tag in
                    NavigationLink(tag) {
                        VStack {
                            Text(tag)
                            Divider()
                            FriendsView(friends: user.friendsArray)
                        }
                    }
                    .font(.footnote)
                    .padding(.horizontal, 5)
                    .foregroundColor(.primary)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                }
            }
            .padding(.vertical)
        }
    }
}
