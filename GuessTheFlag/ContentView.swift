//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leopold Lemmermann on 30.07.21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var animateSpin: [Double] = [0.0, 0.0, 0.0]
    @State private var animateOpacity: [Double] = [1.0, 1.0, 1.0]
    @State private var animateRed: [Double] = [0.0, 0.0, 0.0]
    
    private let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray,.black]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack(spacing: 30) {
                HStack {
                    Text("Tap the flag of: ").foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(countries[number])
                            .overlay(Color.red.opacity(animateRed[number]))
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 10)
                            .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                    .opacity(animateOpacity[number])
                    .rotation3DEffect(
                        .degrees(animateSpin[number]),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                                    }
                Text("Your score is: \(score)")
                    .foregroundColor(.white)
                    .bold()
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is now \(score)."), dismissButton: .default(Text("Continue")) {
                    if scoreTitle == "Correct!" { newRound() }
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            withAnimation {
                animateSpin[correctAnswer] = 360.0
                animateOpacity = [0.25, 0.25, 0.25]
                animateOpacity[correctAnswer] = 1.0
            }
        }
        else {
            scoreTitle = "Wrong!"
            withAnimation {
                animateRed[number] = 0.5
            }
        }
        showingScore = true
    }
    
    func newRound() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animateSpin = [0.0, 0.0, 0.0]
        animateOpacity = [1.0, 1.0, 1.0]
        animateRed = [0.0, 0.0, 0.0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
