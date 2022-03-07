//
//  CityTableViewCell.swift
//  TFS UITableView & Navigation
//
//  Created by Sergey Shalnov on 28.02.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    static let identifier = String(describing: CityTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // очистка данных
    }
}
