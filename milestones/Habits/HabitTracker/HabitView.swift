//
//  HabitView.swift
//  HabitTracker
//
//  Created by Leopold Lemmermann on 05.10.21.
//

import SwiftUI

struct HabitView: View {
    var habit: Habit
    @ObservedObject var userData = UserData()
    
    @State private var count = 0
    
    init(habit: Habit) {
        self.habit = habit
        self.count = userData.counts[habit.id] ?? 0
    }

    var body: some View {
        NavigationView {
            VStack {
                Text(habit.desc)
                    .padding()
                    .navigationTitle(habit.title)
                    .navigationBarTitleDisplayMode(.inline)
                Spacer()
                Divider()
                Stepper("Total Count : \(count)", value: $count)
                    .padding()
                    
            }
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: Habit(title: "Habit", desc: "Description"))
    }
}
