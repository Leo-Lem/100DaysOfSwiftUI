//
//  ContentView.swift
//  Drawing
//
//  Created by Leopold Lemmermann on 23.08.21.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//color cycling rectangle

struct ColorCyclingRect: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
        
    var body: some View {
        VStack {
            ColorCyclingRect(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

//arrow shape
struct Arrow: Shape {
    var thickness: CGFloat
    
    var animatableData: CGFloat {
        get { thickness }
        set { self.thickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX / 2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX / 2 - 1.8*thickness, y: rect.minY + 2*thickness))
        path.addLine(to: CGPoint(x: rect.maxX / 2 - thickness, y: rect.minY + 2*thickness))
        path.addLine(to: CGPoint(x: rect.maxX / 2 - thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 2 + thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 2 + thickness, y: rect.minY + 2*thickness))
        path.addLine(to: CGPoint(x: rect.maxX / 2 + 1.8*thickness, y: rect.minY + 2*thickness))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.minY))
        
        return path
    }
    
}

/*struct ContentView: View {
    @State private var thickness: CGFloat = 10
    
    var body: some View {
        VStack {
            Spacer()
            Arrow(thickness: thickness)
                .frame(width: thickness*5, height: thickness*10)
                .animation(.default)
            Spacer()
            Stepper("Line Thickness: \(Int(thickness))", value: $thickness, in: 2...20, step: 2)
                .padding()
            Spacer().frame(height: 200)
        }
    }
}*/

//** Special Effects
/*struct ContentView: View {
        
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("smokingarea")
                    .resizable()
                    .scaledToFit()
                    .mask(Circle())
                    .overlay(Circle()
                                .stroke(lineWidth: 10)
                                .foregroundColor(.gray))
                    .padding()
                    .frame(width: geo.size.width)
            }
        }
    }
}*/

//** animatableData

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ContentView: View {
    @State private var insetAmount: CGFloat = 50
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    self.insetAmount = CGFloat.random(in: 10...90)
                }
            }
    }
}*/

//** Color cycling
struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

/*struct ContentView: View {
    @State private var colorCycle = 0.0
        
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}*/

//** Flower
struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from:0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        return path
    }
}

/*struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
        
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
                .frame(width: 300, height: 50)
                .border(Color.red, width: 10)
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}*/

//** Triangle and Arc shapes
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = true
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
}

/*struct ContentView: View {
    var body: some View {
        Arc(startAngle: .degress(0), endAngle: .degress(180))
    }
}*/
