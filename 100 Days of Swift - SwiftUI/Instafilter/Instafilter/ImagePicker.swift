//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Anvar Rahimov on 02.08.2022.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable  {
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
}
