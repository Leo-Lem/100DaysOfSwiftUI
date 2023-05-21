//
//  ContentView.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 10.11.21.
//

import SwiftUI
import CoreData

struct UsersView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \User.name, ascending: true)
    ]) var users: FetchedResults<User>
    @State private var filter = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    HStack {
                        NavigationLink(user.wrappedName) {
                            UserView(user: user)
                        }
                            IsActiveView(user.isActive)
                    }
                }
            }
            .searchable(text: $filter)
            .task {
                moc.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                addToContext(
                    await loadData(from: "https://www.hackingwithswift.com/samples/friendface.json", to: [User](), context: moc) ?? [User](),
                    context: moc)
                try? moc.save()
            }
        }
    }
}

/*extension UsersView {
    var filteredUsers: [User] {
        if filter.isEmpty {
            return Array(users)
        } else {
            return users.filter { user in
                user.wrappedName.contains(filter)}
        }
    }
}*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView().previews()
    }
}
