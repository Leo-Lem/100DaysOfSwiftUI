//
//  RatingView.swift
//  Bookworm
//
//  Created by Leopold Lemmermann on 31.10.21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")
    
    func image(for number: Int) -> some View {
        if number > rating {
            return offImage.foregroundColor(Color.gray)
        } else { return onImage.foregroundColor(Color.yellow) }
    }
    
    var body: some View {
        HStack {
            if label.isEmpty == false { Text(label) }
            ForEach(1..<maximumRating + 1) { n in
                self.image(for: n)
                    .onTapGesture { self.rating = n }
            }
        }
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityLabel("\(rating == 1 ? "1 star" : "\(rating) stars")")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: if rating < maximumRating { rating += 1 }
            case .decrement: if rating > 1 { rating -= 1 }
            default: break
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        return RatingView(rating: .mock(3))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
