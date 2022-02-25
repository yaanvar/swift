//
//  ViewController.swift
//  ProjectChallenge9
//
//  Created by Anvar Rahimov on 25.02.2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MemeGenerator"
        navigationController?.navigationBar.prefersLargeTitles = true
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addText))
        let photo = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        navigationItem.leftBarButtonItems = [photo, compose]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
        
        picker.delegate = self
        
    }
    
    @objc func importPicture() {
        let ac = UIAlertController(title: "Choose source:", message: nil, preferredStyle: .actionSheet)
        ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: openCamera))
        ac.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: openPhotoLibrary))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        imageView.image = image
    }
    
    @objc func addText() {
        if imageView.image != nil {
            let ac = UIAlertController(title: "Enter text for your meme", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addTextField()
            ac.textFields?[0].placeholder = "Enter top line text"
            ac.textFields?[1].placeholder = "Enter bottom line text"
            ac.addAction(UIAlertAction(title: "Apply changes", style: .default, handler: { [weak self] _ in
                guard let topLine = ac.textFields?[0].text else { return }
                guard let bottomLine = ac.textFields?[1].text else { return }
                
                self?.applyChanges(topLine: topLine, bottomLine: bottomLine)
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Choose photo for meme first", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func openCamera(action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "We can't access your camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func openPhotoLibrary(action: UIAlertAction) {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func applyChanges(topLine: String, bottomLine: String) {
        guard let image = imageView.image else { return }
        let render = UIGraphicsImageRenderer(size: image.size)
        
        print(bottomLine)
        print(topLine)
        
        let img = render.image { context in
            
            let photo = image
            photo.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 124),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white
            ]
            
            var attributedString = NSAttributedString(string: topLine, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: 10, width: image.size.width, height: 400), options: .usesLineFragmentOrigin, context: nil)
            attributedString = NSAttributedString(string: bottomLine, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: image.size.height - 210, width: image.size.width, height: 400), options: .usesLineFragmentOrigin, context: nil)
            
        }
        
        imageView.image = img
    }
    
    @objc func sharePhoto() {
        guard let image = imageView.image else {
            let alert  = UIAlertController(title: "Warning", message: "You have nothing to share, man..", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        let vc = UIActivityViewController(activityItems: [image, "MemeGenerator app"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

