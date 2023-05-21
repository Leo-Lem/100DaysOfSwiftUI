//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Leopold Lemmermann on 02.11.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let persistence = PersistenceController.shared
    @State private var candy: Candy?
    
    var body: some View {
        Button("Click me") {
            candy = Candy(entity: Candy.entity(), insertInto: nil)
            candy?.wrappedName = "Hello"
            print(candy)
            candy?.wrappedName = "Moin"
            print(candy)
        }
    }
}

/*
struct ContentView: View {
    @State private var showView = 3
    
    @Environment(\.managedObjectContext) private var moc
    
    @State private var filterKey = "lastName"
    @State private var filterType: FilterType = .beginsWith
    @State private var filterValue = "A"
    @State private var sortOrder = true
    var sortBy: [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Singer.lastName, ascending: sortOrder)]
    }
    
    @FetchRequest(entity: Wizard.entity(),
                  sortDescriptors: [],
                  animation: .default)
    private var wizards: FetchedResults<Wizard>

    @FetchRequest(entity: Ship.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "name < %@", "F"),//NSPredicate(format: "universe == %@", "Star Wars"),
                  animation: .default)
    private var ships: FetchedResults<Ship>
    
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            Picker("View No. ", selection: $showView) {
                ForEach(0..<4) { i in Text("\(i+1)") }
            }.pickerStyle(.segmented).padding()
            
            switch showView {
            case 0:
                List(wizards, id: \.self) { wizard in
                    Text(wizard.name ?? "Unknown")
                }
                HStack {
                    Button("Add") {
                        let wizard = Wizard(context: moc)
                        wizard.name = "Harry Potter"
                    }
                    Button("Save") {
                        do {
                            if self.moc.hasChanges { try self.moc.save() }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            case 1:
                List(ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown name")
                }
                Button("Add Examples") {
                    let ship1 = Ship(context: self.moc)
                    ship1.name = "Enterprise"
                    ship1.universe = "Star Trek"

                    let ship2 = Ship(context: self.moc)
                    ship2.name = "Defiant"
                    ship2.universe = "Star Trek"

                    let ship3 = Ship(context: self.moc)
                    ship3.name = "Millennium Falcon"
                    ship3.universe = "Star Wars"

                    let ship4 = Ship(context: self.moc)
                    ship4.name = "Executor"
                    ship4.universe = "Star Wars"

                    try? self.moc.save()
                }
            case 2:
                FilteredList(filterKey: filterKey, filterType: filterType, filterValue: filterValue, sortBy: sortBy) { (item: Singer) in
                    Text("\(item.wrappedFirstName) \(item.wrappedLastName)")
                }
                    Button("Add Examples") {
                        let mikael = Singer(context: self.moc)
                        mikael.firstName = "Mikael"
                        mikael.lastName = "Akerfeldt"

                        let steven = Singer(context: self.moc)
                        steven.firstName = "Steven"
                        steven.lastName = "Wilson"

                        let jens = Singer(context: self.moc)
                        jens.firstName = "Jens"
                        jens.lastName = "Kidman"
                        
                        let dickie = Singer(context: self.moc)
                        dickie.firstName = "Dickie"
                        dickie.lastName = "Allen"
                        
                        let alex = Singer(context: self.moc)
                        alex.firstName = "Alexandr"
                        alex.lastName = "Shikolai"
                        
                        let corey = Singer(context: self.moc)
                        corey.firstName = "Corey"
                        corey.lastName = "Taylor"
                        
                        try? self.moc.save()
                    }.padding()
                    
                    Toggle("Sort Order", isOn: $sortOrder).padding()
                HStack {
                    Button("First or Last") {
                        if self.filterKey == "lastName" { self.filterKey = "firstName" }
                        else { self.filterKey = "lastName" }
                    }.padding()
                    
                    Button("Begin or End") {
                        if self.filterType == .beginsWith { self.filterType = .endsWith}
                        else { self.filterType = .beginsWith }
                    }.padding()
                }
                
                TextField("Filter", text: $filterValue).multilineTextAlignment(.center)
            case 3:
                VStack {
                    List {
                        ForEach(countries, id: \.self) { country in
                            Section(country.wrappedFullName) {
                                ForEach(country.candyArray, id: \.self) { candy in
                                    Text(candy.wrappedName)
                                }
                            }
                        }
                    }
                    Button("Add") {
                        let candy1 = Candy(context: self.moc)
                        candy1.name = "Mars"
                        candy1.origin = Country(context: self.moc)
                        candy1.origin?.shortName = "UK"
                        candy1.origin?.fullName = "United Kingdom"

                        let candy2 = Candy(context: self.moc)
                        candy2.name = "KitKat"
                        candy2.origin = Country(context: self.moc)
                        candy2.origin?.shortName = "UK"
                        candy2.origin?.fullName = "United Kingdom"

                        let candy3 = Candy(context: self.moc)
                        candy3.name = "Twix"
                        candy3.origin = Country(context: self.moc)
                        candy3.origin?.shortName = "UK"
                        candy3.origin?.fullName = "United Kingdom"

                        let candy4 = Candy(context: self.moc)
                        candy4.name = "Toblerone"
                        candy4.origin = Country(context: self.moc)
                        candy4.origin?.shortName = "CH"
                        candy4.origin?.fullName = "Switzerland"

                        try? self.moc.save()
                    }
                }
            default: Text("Hello World")
            }
        }
    }
}
*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
