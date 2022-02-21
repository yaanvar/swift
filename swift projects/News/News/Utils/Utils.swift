//
//  Utils.swift
//  News
//
//  Created by Anvar Rahimov on 06.02.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
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
}
