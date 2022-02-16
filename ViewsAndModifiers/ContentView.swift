//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        Text("This is a title").prominentTitle()
        
        Section("background") {
            VStack {
                Text("Hello, world!")
                    .padding()
                    .background(.red)
                    
                Text("Hello, world!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
            }
            .frame(height: 400)
        }
        
        Section("modifier order") {
            ScrollView(.horizontal) {
                HStack {
                    Button("Hello, world!", action: { print(type(of: self.body)) })
                        .background(.red)
                        .frame(width: 200, height: 200)
                    
                    Button("Hello, world!", action: { print(type(of: self.body)) })
                        .frame(width: 200, height: 200)
                        .background(.red)
                }
                
                Text("Hello, world!")
                    .padding()
                    .background(.red)
                    .padding()
                    .background(.blue)
                    .padding()
                    .background(.green)
                    .padding()
                    .background(.yellow)
            }
        }
        
        Section("conditional modifiers") {
            HStack {
                Button("Hello World", toggle: $red)
                    .foregroundColor(red ? .red : .blue)
                
                Divider()
                Spacer()
                
                if red {
                    Button("Hello World", toggle: $red)
                        .foregroundColor(.red)
                } else {
                    Button("Hello World", toggle: $red)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                Divider()
                
                Button("Hello World", toggle: $red)
                    .if(red) { $0.foregroundColor(.red) }
            }
            .buttonStyle(.borderless)
        }
        
        Section("environment modifiers") {
            HStack {
                VStack {
                    Text("Gryffindor")
                        .font(.largeTitle)
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .font(.title)
                
                Spacer()
                Divider()
                Spacer()
                
                VStack {
                    Text("Gryffindor")
                        .blur(radius: 0)
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .blur(radius: 5)
            }
        }
        
        Section("views as properties") {
            VStack {
                motto1.foregroundColor(.red)
                motto2.foregroundColor(.blue)
            }
        }
        
        Section("view composition") {
            VStack {
                CapsuleText(text: "First")
                    .foregroundColor(.white)
                CapsuleText(text: "Second")
                    .foregroundColor(.yellow)
            }
        }
        
        Section("custom modifiers") {
            VStack {
                Text("Hello, world!").modifier(Title())
                Color.blue
                    .frame(width: 300, height: 200)
                    .watermarked(with: "Hacking with Swift")
            }
        }
        
        Section("custom containers") {
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
            .lineLimit(0)
            .minimumScaleFactor(0.5)
        }
    }
    
    //MARK: - conditional modifiers
    @State private var red = false
    
    //MARK: - views as parameters
    let motto1 = Text("Draco dormiens"), motto2 = Text("nunquam titillandus")
    
    //MARK: - view composition
    struct CapsuleText: View {
        let text: String
        
        var body: some View {
            Text(text, font: .largeTitle)
                .padding()
                .background(.blue)
                .clipShape(.capsule)
        }
    }
}

//MARK: - custom modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(.roundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    let text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View { modifier(Title()) }
    func watermarked(with text: String) -> some View { modifier(Watermark(text: text)) }
    func prominentTitle() -> some View { modifier(ProminentTitle()) }
}

//MARK: - Custom containers
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Form { ContentView() }
    }
}
