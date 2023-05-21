//
//  Prospects.swift
//  HotProspects
//
//  Created by Leopold Lemmermann on 24.01.22.
//

import Foundation

@MainActor protocol ProspectsProtocol: ObservableObject {
    var people: [Prospect] { get }
    
    func add(_ prospect: Prospect)
    func toggle(_ prospect: Prospect)
    
    func load()
    func save()
}

class Prospects: ProspectsProtocol {
    private(set) var people = [Prospect]() {
        willSet { objectWillChange.send() }
        didSet { save() }
    }
    
    func add(_ prospect: Prospect) { people.append(prospect) }
    
    func toggle(_ prospect: Prospect) {
        guard let index = people.firstIndex(where: { $0.id == prospect.id }) else { return }
        
        people[index].isContacted.toggle()
        
        save()
    }
    
    //MARK: - persistence
    init() { load() }
    
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("people-data")
    
    func load() {
        if let path = path,
            let data = try? Data(contentsOf: path),
           let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
            self.people = decoded
        }
    }
    
    func save() {
        if let path = path,
           let data = try? JSONEncoder().encode(self.people) {
            do { try data.write(to: path) } catch { print(error) }
        }
    }
}

struct Prospect: Identifiable, Codable {
    let id: UUID, timestamp: Date
    var name: String, email: String?
    var isContacted = false
    
    init(name: String = "Anonymous", email: String? = nil) {
        self.id = UUID()
        self.timestamp = Date()
        self.name = name
        self.email = email
    }
}

class MockProspects: ProspectsProtocol {
    private(set) var people: [Prospect] = []
    
    init() {
        for i in 0..<10 {
            add(Prospect(name: "User #\(i)", email: "user\(10-i)@example.com"))
        }
    }
    
    func add(_ prospect: Prospect) { people.append(prospect) }
    func toggle(_ prospect: Prospect) {
        guard let index = people.firstIndex(where: { $0.id == prospect.id }) else { return }
        people[index].isContacted.toggle()
    }
    
    func load() { print("loading") }
    func save() { print("saving") }
}
