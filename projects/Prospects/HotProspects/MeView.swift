//
//  MeView.swift
//  HotProspects
//
//  Created by Leopold Lemmermann on 24.01.22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title2)

                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title2)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            ImageSaver().writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save To Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Your code").font(.title).bold()
                }
            }
        }
    }
    
    @State private var name = "Leopold Lemmermann"
    @State private var email = "leopold@lemmermann.com"
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    private var qrCode: UIImage { generateQRCode(from: "\(name)\n\(email)") }
    
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
