//
//  Extensions.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import UIKit

//MARK: - UIImageView

extension UIImageView {
    func loadImage(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .background).async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
    func setRound() {
        let radius = self.bounds.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
