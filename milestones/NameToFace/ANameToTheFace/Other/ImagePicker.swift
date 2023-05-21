//
//  ImagePicker.swift
//  ANameToTheFace
//
//  Created by Leopold Lemmermann on 04.01.22.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    private enum ImagePickerType: String, CaseIterable {
        case camera = "camera", library = "photo.on.rectangle"
    }
    
    @State private var type: ImagePickerType = .library
    @Binding var image: UIImage?
    
    var body: some View {
        Group {
            switch type {
            case .library:
                LibraryImagePicker($image)
            case .camera:
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    CameraImagePicker($image)
                } else {
                    Text("Camera unavailable...")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
                Picker("", selection: $type) {
                    ForEach(ImagePickerType.allCases, id: \.self) { type in
                        Image(systemName: type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .frame(maxWidth: 100)
        }
    }
}

struct CameraImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    init(_ image: Binding<UIImage?>) { self._image = image }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        
        vc.delegate = context.coordinator
        vc.sourceType = .camera
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
}

extension CameraImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        private let parent: CameraImagePicker
        init(_ parent: CameraImagePicker) { self.parent = parent }
        
        func picker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            
            DispatchQueue.main.async {
                self.parent.image = selectedImage
            }
        }
    }
}

public struct LibraryImagePicker: UIViewControllerRepresentable {
    @Binding private var image: UIImage?
    public init(_ image: Binding<UIImage?>) { self._image = image }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = context.coordinator
        
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    public func makeCoordinator() -> Coordinator { Coordinator(self) }
}

extension LibraryImagePicker {
    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let parent: LibraryImagePicker
        public init(_ parent: LibraryImagePicker) { self.parent = parent }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}
