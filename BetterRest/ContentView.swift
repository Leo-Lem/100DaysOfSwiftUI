//
//  ContentView.swift
//  BetterRest
//
//  Created by Leopold Lemmermann on 01.08.21.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var comps = DateComponents()
        comps.hour = 5
        comps.minute = 55
        return Calendar.current.date(from: comps) ?? Date()
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.5
    @State private var coffeeAmount = 0.0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                    
                    Slider(value: $coffeeAmount, in: 0...20, step: 1)
                    Text("\(coffeeAmount, specifier: "%g") cup(s)").frame(maxWidth: .infinity)
                    
                    /*Picker(selection: $coffeeAmount, label: Text("Daily coffee intake")) {
                        ForEach(0..<21) { cups in
                            Text("\(cups) cups")
                        }
                    }
                    
                    Stepper(value: $coffeeAmount, in: 0...20) {
                        if coffeeAmount == 1 {
                            Text("1 Cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }*/
                }
            }
            .navigationBarTitle("Bedtime: \(estimatedBedtime)")
        }
    }

    var estimatedBedtime: String {
        let model = SleepCalculator()
        
        let estimatedSleep = sleepAmount
        let coffee = Double(coffeeAmount)
        let comps = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (comps.hour ?? 0) * 60^2
        let minute = (comps.minute ?? 0) * 60
        let wake = Double(hour + minute)
        
        do {
            let pred = try model.prediction(wake: wake, estimatedSleep: estimatedSleep, coffee: coffee)
            
            let sleepTime = wakeUp - pred.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            print("Error in prediction")
        }
        return "Error..."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
