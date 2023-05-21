//
//  ContentView.swift
//  Dices
//
//  Created by Leopold Lemmermann on 09.02.22.
//

import SwiftUI

func edgeEffect(_ edge: Edge, inset: Double = 0.2, geos: (inner: GeometryProxy, outer: GeometryProxy)) -> Double {
  let rel = (
    x: geos.inner.frame(in: .global).midX / geos.outer.size.width,
    y: geos.inner.frame(in: .global).midY / geos.outer.size.height
  )

  let effect: Double

  switch edge {
  case .top: effect = min(rel.y - inset, 0)
  case .bottom: effect = min(1 - rel.y - inset, 0)
  case .leading: effect = min(rel.x - inset, 0)
  case .trailing: effect = min(1 - rel.x - inset, 0)
  }

  return -effect / inset
}

struct ContentView: View {
  var body: some View {
    VStack {
      GeometryReader { geo1 in
        ScrollView(.horizontal) {
          LazyHGrid(rows: Array(repeating: GridItem(), count: 5)) {
            ForEach(rolls, id: \.1) { roll, _ in
              GeometryReader { geo in
                Text("\(roll)")
                  .foregroundColor(.black)
                  .frame(width: 25, height: 25)
                  .background(.white)
                  .cornerRadius(10)
                  .shadow(radius: 5)
                  .rotation3DEffect(
                    .degrees(
                      max(
                        edgeEffect(.leading, geos: (geo, geo1)) * 90,
                        edgeEffect(.trailing, geos: (geo, geo1)) * 90
                      )
                    ),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0
                  )
                  .opacity(
                    min(
                      1 - edgeEffect(.leading, inset: 0.1, geos: (geo, geo1)) * 3,
                      1 - edgeEffect(.trailing, inset: 0.1, geos: (geo, geo1)) * 3
                    )
                  )
              }
              .padding()
            }
          }
        }
      }
      .frame(height: 200)

      Text("\(current)")
        .foregroundColor(.black)
        .frame(width: 100, height: 100)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .onTapGesture {
          current = Int.random(in: 1 ... 6)

          rolls.append((current, Date()))
        }
    }
  }

  @State private var current: Int = 1
  @State private var rolls: [(Int, timestamp: Date)] = []
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
