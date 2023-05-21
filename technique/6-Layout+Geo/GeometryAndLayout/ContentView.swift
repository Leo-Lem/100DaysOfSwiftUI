//
//  ContentView.swift
//  GeometryAndLayout
//
//  Created by Leopold Lemmermann on 09.02.22.
//

import SwiftUI
import MySwiftUI

struct ContentView: View {
    var body: some View {
        //MARK: image layout
        VStack {
            Image("background")
                .frame(width: 100, height: 100)
                .overlay(.blue.opacity(0.2))
            
            Image("background")
                .resizable()
                .frame(width: 100, height: 100)
                .overlay(.red.opacity(0.2))
        }
        
        VStack {
            Text("Live long and prosper")
                .frame(width: 300, height: 300, alignment: .bottomLeading)
            
            Text("Live ").font(.caption)
            + Text("long ")
            + Text("and ").font(.title)
            + Text("prosper").font(.largeTitle)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Live").font(.caption)
                Text("long")
                Text("and").font(.title)
                Text("prosper").font(.largeTitle)
            }
        }
        
        VStack {
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in d[.trailing] }
                Text("This is a longer line of text")
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
            
            VStack(alignment: .leading) {
                ForEach(0..<10) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
                }
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
        }
            
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("background")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
        
        VStack {
            Text("Hello, world!")
                .background(.red.opacity(0.5))
                .position(x: 100, y: 100)
                .background(.blue.opacity(0.5))
            
            Text("Hello, world!")
                .background(.red)
                .offset(x: 100, y: -100)
                .background(.blue)
        }
        
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(.red)
            }
            .background(.green)

            Text("More text")
                .background(.blue)
            
            OuterView()
                .background(.red)
                .coordinateSpace(name: "Custom")
        }
        
        GeometryReader<AnyView> { geo1 in
            var height: Double { geo1.size.height }
            
            return ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader<AnyView> { geo2 in
                        var global: (x: Double, y: Double) { (geo2.frame(in: .global).midX, geo2.frame(in: .global).midY) }
                        
                        return Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(hue: min((global.y / height), 1), saturation: 1, brightness: 1)
                            )
                            .group { view in
                                return view
                                    .opacity(
                                        min(
                                            min((global.y / height) * 10, 1),
                                            min((1 - (global.y / height)) * 10, 1)
                                        )
                                    )
                                    .rotation3DEffect(.degrees(global.y - height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            }.eraseToAnyView()
                    }
                    .frame(height: 40)
                }
            }.eraseToAnyView()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
    
    struct OuterView: View {
        var body: some View {
            VStack {
                Text("Top")
                InnerView().background(.green)
                Text("Bottom")
            }
        }
        
        struct InnerView: View {
            var body: some View {
                HStack {
                    Text("Left")
                    GeometryReader { geo in
                        Text("Center")
                            .background(.blue)
                            .onTapGesture {
                                print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                                print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                                print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                            }
                    }
                    .background(.orange)
                    Text("Right")
                }
            }
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
