//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Leopold Lemmermann on 24.01.22.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView<P: ProspectsProtocol>: View {
    @EnvironmentObject var prospects: P
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people) { prospect in
                    HStack {
                        Label("Contacted?", systemImage: "person.crop.circle.\(prospect.isContacted ? "fill.badge.checkmark" : "badge.xmark")")
                            .labelStyle(.iconOnly)
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email ?? "no email")
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            Task { do { try await addNotification(for: prospect) } catch { print(error) }}
                        } label: {
                            Label("Remind Me", systemImage: "bell")
                        }
                        .tint(.orange)
                    }
                    .swipeActions {
                        Button(action: { prospects.toggle(prospect) }) {
                            Label("Mark \(prospect.isContacted ? "Uncontacted" : "Contacted")",
                                  systemImage: "person.crop.circle.\(prospect.isContacted ? "badge.xmark" : "fill.badge.checkmark")")
                        }
                    }
                }
            }
            .confirmationDialog("Sort By", isPresented: $sorter) {
                ForEach(SortType.allCases, id:\.self) { type in
                    Button(type.rawValue) { self.sortBy = type }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { sorter = true }) {
                        Label("Scan", systemImage: "arrow.up.arrow.down.square")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { scanner = true }) {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("\(title) (\(people.count))").font(.title).bold()
                }
            }
            .sheet(isPresented: $scanner) {
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
            }
        }
    }
    
    @State private var scanner = false
    @State private var sorter = false
    @State private var sortBy: SortType = .name
}

extension ProspectsView {
    func addNotification(for prospect: Prospect) async throws {
        let center = UNUserNotificationCenter.current()

        let request: UNNotificationRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email ?? "no email given"
            content.sound = UNNotificationSound.default

            #if DEBUG
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            #else
            let dateComponents = DateComponents(hour: 9)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            #endif

            return UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        }()
        
        let settings = await center.notificationSettings()
        
        if settings.authorizationStatus == .authorized {
            try await center.add(request)
        } else {
            let authorized = try await center.requestAuthorization(options: [.alert, .badge, .sound])
            if authorized { try await center.add(request) } else { print("D'oh") }
        }
        
        print("Notification scheduled")
    }
}

extension ProspectsView {
    private func handleScan(result: Result<ScanResult, ScanError>) {
        scanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], email: details[1])
            
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

extension ProspectsView {
    private var people: [Prospect] {
        var people = [Prospect]()
        
        switch filter {
        case .none: people = prospects.people
        case .contacted: people = prospects.people.filter { $0.isContacted }
        case .uncontacted: people = prospects.people.filter { !$0.isContacted }
        }
        
        switch sortBy {
        case .recent: people = people.sorted { $0.timestamp > $1.timestamp }
        case .name: people = people.sorted { $0.name < $1.name }
        case .email: people = people.sorted { $0.email ?? "" < $1.email ?? "" }
        }
        
        return people
    }
}

extension ProspectsView {
    enum SortType: String, CaseIterable { case name = "By Name",
                                       email = "By Email",
                                       recent = "Most Recent" }
}

extension ProspectsView {
    enum FilterType { case none, contacted, uncontacted }
    
    private var title: String {
        switch filter {
        case .none: return "Everyone"
        case .contacted: return "Contacted"
        case .uncontacted: return "Uncontacted"
        }
    }
}

//MARK: - Previews
struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView<MockProspects>(filter: .none)
            .environmentObject(MockProspects())
    }
}
