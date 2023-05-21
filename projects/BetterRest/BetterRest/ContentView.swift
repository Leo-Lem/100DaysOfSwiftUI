//
//  ContentView.swift
//  BetterRest
//
//  Created by Leopold Lemmermann on 01.08.21.
//

import SwiftUI
import CoreML
import MyDates
import MySwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Section("When do you want to wake up?") {
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
            }
            
            Section("Desired amount of sleep") {
                Stepper("\(sleep.formatted()) hours", value: $sleep, in: 4...12, step: 0.25)
            }
            
            Section("Daily coffee intake (\(coffee.formatted()) cups)") {
                Slider(value: $coffee, in: 0...20, step: 1)
            }
        }
        .alert(error?.title ?? "", item: $error, message: { Text($0.message) })
        .navigationTitle("Bedtime: \(getBedtime() ?? "<Error>")")
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleep = 8.5
    @State private var coffee = 0.0
    
    @State private var error: (title: String, message: String)? = nil
}

extension ContentView {
    private static let defaultWakeTime: Date = Calendar.current.date(bySettingHour: 6, minute: 55, second: 0, of: Date.now) ?? Date.now

    private func getBedtime() -> String? {
        do {
            let bedtime = try estimateBedtime(wakeUp: wakeUp, sleep: sleep, coffee: coffee)
            return bedtime.formatted(date: .omitted, time: .shortened)
        } catch {
            self.error = ("Error", "Sorry, there was a problem calculating your bedtime.")
            return nil
        }
    }
    
    private func estimateBedtime(wakeUp: Date, sleep estimatedSleep: Double, coffee: Double) throws -> Date {
        let wake = wakeUp.distance(to: wakeUp.startOf(.day) ?? wakeUp, unit: .second)!,
            config = MLModelConfiguration(),
            model = try SleepCalculator(configuration: config),
            pred = try model.prediction(wake: wake, estimatedSleep: estimatedSleep, coffee: coffee)
        return wakeUp - pred.actualSleep
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
