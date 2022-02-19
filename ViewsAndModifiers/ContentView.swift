//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Leopold Lemmermann on 14.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    @State private var section: Int = 0
    
    var body: some View {
        TabView(selection: $section) {
            Section {
                Text("This is a title")
                    .prominentTitle()
            }
            .navigationTitle("A Modifier")
            .tag(0)
            
            Section {
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
            .navigationTitle(".background")
            .tag(1)
            
            Section {
                VStack {
                    Button("Hello, world!", action: { print(type(of: self.body)) })
                        .background(.red)
                        .frame(width: 150, height: 150)
                    
                    Button("Hello, world!", action: { print(type(of: self.body)) })
                        .frame(width: 150, height: 150)
                        .background(.red)
                    
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
            .navigationTitle("Modifier Order")
            .tag(2)
            
            Section {
                VStack {
                    Button("Hello, Kinsman!", toggle: $colors.red)
                        .foregroundColor(colors.red ? .red : .blue)
                    
                    Divider()
                    
                    if colors.green {
                        Button("Hello, Friend!", toggle: $colors.green)
                            .foregroundColor(.green)
                    } else {
                        Button("Hello, Friend!", toggle: $colors.green)
                            .foregroundColor(.blue)
                    }
                    
                    Divider()
                    
                    Button("Hello, World!", toggle: $colors.yellow)
                        .if(colors.yellow) { $0.foregroundColor(.yellow) }
                }
                .buttonStyle(.borderless)
            }
            .navigationTitle("Conditional Modifiers")
            .tag(3)
            
            Section {
                HStack {
                    VStack {
                        Text("Gryffindor")
                            .font(.largeTitle)
                        Text("Hufflepuff")
                        Text("Ravenclaw")
                        Text("Slytherin")
                    }
                    .font(.title)
                    
                    Divider()
                    
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
            .navigationTitle("Environment Modifiers")
            .tag(4)
            
            Section {
                VStack {
                    motto1.foregroundColor(.red)
                    motto2.foregroundColor(.blue)
                }
            }
            .navigationTitle("Views as Properties")
            .tag(5)
            
            Section {
                VStack {
                    CapsuleText(text: "First")
                        .foregroundColor(.white)
                    CapsuleText(text: "Second")
                        .foregroundColor(.yellow)
                }
            }
            .navigationTitle("View Composition")
            .tag(6)
            
            Section {
                VStack {
                    Text("Hello, world!").modifier(Title())
                    Color.blue
                        .frame(width: 300, height: 200)
                        .watermarked(with: "Hacking with Swift")
                }
            }
            .navigationTitle("Custom Modifiers")
            .tag(7)
            
            Section {
                GridStack(rows: 4, columns: 4) { row, col in
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
            }
            .navigationTitle("custom containers")
            .tag(8)
        }
        .border(.primary)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Select Tab", selection: $section, items: 0..<8) { Text("\($0 + 1)") }
                    .pickerStyle(.segmented)
            }
        }
        .embedInNavigation()
        .navigationViewStyle(.stack)
    }
    
    //MARK: - conditional modifiers
    @State private var colors: (red: Bool, green: Bool, yellow: Bool) = (false, false, false)
    
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
        ContentView()
    }
}
