//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Leopold Lemmermann on 03.11.21.
//

import SwiftUI
import CoreData

enum FilterType: String {
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    let content: (T) -> Content
    
    init(filterKey: String, filterType: FilterType, filterValue: String, sortBy: [NSSortDescriptor],
         @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortBy, predicate: NSPredicate(format: "%K \(filterType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "lastName", filterType: .beginsWith, filterValue: "S", sortBy: []) { (item: Singer) in
            Text("\(item.wrappedFirstName) \(item.wrappedLastName)")
        }
    }
}
