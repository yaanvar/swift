//
//  TaskTypeCell.swift
//  TO-DO Manager
//
//  Created by Anvar Rahimov on 30.10.2021.
//

import UIKit

class TaskTypeCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet var typeTitle: UILabel!
    @IBOutlet var typeDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
