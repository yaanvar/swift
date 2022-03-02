//
//  DetailViewController.swift
//  ProjectChallenge4
//
//  Created by Anvar Rahimov on 10.02.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var imageView: UIImageView!
    var photo: Photo!

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        
        title = photo.name
        navigationItem.largeTitleDisplayMode = .never
        
        imageView = UIImageView()
        let path = getDocumenDirectory().appendingPathComponent(photo.image)
        imageView.image =  UIImage(contentsOfFile: path.path)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
