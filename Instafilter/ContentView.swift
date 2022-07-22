//
//  ContentView.swift
//  Instafilter
//
//  Created by Leopold Lemmermann on 01.12.21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import MyCustomUI
import MyOthers

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    private let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ClickToSelectImage($image, with: selectImage)
                Slider(value: $filterIntensity, in: 0.01...1) {
                    Text("Intensity")
                } minimumValueLabel: {
                    Text("0%")
                } maximumValueLabel: {
                    Text("100%")
                }
                .padding()
                .onChange(of: filterIntensity) { _ in processImage() }
            }
            .navigationTitle("Instafilter")
            .toolbar {
                ButtonToolbar(["Change Filter", "Save"],
                              leftAction: changeFilter, rightAction: saveImage,
                              rightDisabled: image == nil)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker($inputImage)
                    .onChange(of: inputImage) { _ in loadImage() }
            }
            .confirmationDialog("Select A Filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(.crystallize()) }
                Button("Edges") { setFilter(.edges()) }
                Button("Gaussian Blur") { setFilter(.gaussianBlur()) }
                Button("Pixellate") { setFilter(.pixellate()) }
                Button("Sepia Tone") { setFilter(.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(.unsharpMask()) }
                Button("Vignette") { setFilter(.vignette()) }
                Button("Gloom") { setFilter(.gloom()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    private func selectImage() {
        showingImagePicker = true
    }
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        processImage()
    }
    private func processImage() {
        if currentFilter.inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if currentFilter.inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if currentFilter.inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            processedImage = UIImage(cgImage: cgImage)
            guard let processedImage = processedImage else { return }
            image = Image(uiImage: processedImage)
        }
    }
    private func changeFilter() {
        showingFilterSheet = true
    }
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    private func saveImage() {
        guard let processedImage = processedImage else { return }
        ImageSaver(successHandler: { print("Success!") },
                   errorHandler: { print("Oops: \($0.localizedDescription)") })
            .writeToPhotoAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
