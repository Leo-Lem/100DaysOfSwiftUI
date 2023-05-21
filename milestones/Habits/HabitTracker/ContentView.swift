//
//  ContentView.swift
//  HabitTracker
//
//  Created by Leopold Lemmermann on 05.10.21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddHabit = false
    
    @State private var habits = [Habit]()
    @StateObject var userData = UserData()
    
    var testHabit = Habit(title: "My Habit", desc: "This is my habit. I like to think of this as more than a placeholder text. It can be so much more. Just imagine the possibilities!")
    
    @State private var title = ""
    @State private var desc = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    GeometryReader { geo in
                        NavigationLink(destination: HabitView(habit: habit)) {
                            VStack(alignment: .leading) {
                                Text(habit.title)
                                    .font(.headline)
                                Text(habit.desc)
                                    .minimumScaleFactor(0.7)
                                    .frame(width: geo.size.width * 0.8)
                            }
                            Divider()
                            Text("\(userData.counts[habit.id] ?? 0)")
                        }
                    }
                }
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                Button(action: {
                    //showingAddHabit = true
                    habits.append(testHabit)
                    
                    print(userData.counts)
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .popover(isPresented: $showingAddHabit) {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $desc)
                
                Section {
                    Button("Save") {
                        habits.append(Habit(title: title, desc: desc))
                        title = ""; desc = ""
                        showingAddHabit = false
                    }
                    .disabled(title.isEmpty)
                    Button("Cancel") {
                        title = ""; desc = ""
                        showingAddHabit = false
                    }
                    .foregroundColor(Color.red)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
