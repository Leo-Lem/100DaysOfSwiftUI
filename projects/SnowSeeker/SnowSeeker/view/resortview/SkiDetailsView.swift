//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Leopold Lemmermann on 12.02.22.
//

import SwiftUI
import MySwiftUI

extension ResortView {
    struct SkiDetails: View {
        let resort: Resort
        
        var body: some View {
            Group {
                VStack {
                    Text("Elevation", font: .caption.bold())
                    Text("\(resort.elevation)m", font: .title3)
                }

                VStack {
                    Text("Snow", font: .caption.bold())
                    Text("\(resort.snowDepth)cm", font: .title3)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HStack { ResortView.SkiDetails(resort: .example) }
    }
}
