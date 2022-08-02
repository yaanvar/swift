//
//  ContentView.swift
//  Instafilter
//
//  Created by Anvar Rahimov on 02.08.2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
