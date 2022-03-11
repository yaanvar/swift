//
//  DetailViewController.swift
//  Project38
//
//  Created by Anvar Rahimov on 11.03.2022.
//
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var detailLabel: UILabel!
	var detailItem: Commit?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let detail = self.detailItem {
			detailLabel.text = detail.message
		}
    }
}
