//
//  Extensions.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import UIKit

//MARK: - UIView

extension UIView {
    
    func setRound() {
        let radius = self.bounds.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
}

