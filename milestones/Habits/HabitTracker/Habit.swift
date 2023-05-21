//
//  Habit.swift
//  HabitTracker
//
//  Created by Leopold Lemmermann on 05.10.21.
//

import Foundation

struct Habit: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
    
    /*var count: Int {
        if userData.counts[self.id] ?? 0 < 0 { return 0 }
        else { return userData.counts[self.id] ?? 0 }
        //didSet { if count < 0 { count = 0 } }
    }*/
    
    init(title: String, desc: String) {
        UserData().counts[self.id] = 0
        self.title = title
        self.desc = desc
    }
}

class UserData: ObservableObject {
    @Published var counts = [UUID:Int]()
}
