//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import SwiftUI
import MySwiftUI

extension ResortView {
    struct Details: View {
        let resort: Resort
        
        var body: some View {
            Group {
                VStack {
                    Text("Size", font: .caption.bold())
                    Text(size, font: .title3)
                }

                VStack {
                    Text("Price", font: .caption.bold())
                    Text(price, font: .title3)
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        private var size: String {
            switch resort.size {
            case 1: return "Small"
            case 2: return "Average"
            default: return "Large"
            }
        }
        
        private var price: String {
            String(repeating: "$", count: resort.price)
        }
    }
}
struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HStack { ResortView.Details(resort: .example) }
    }
}
