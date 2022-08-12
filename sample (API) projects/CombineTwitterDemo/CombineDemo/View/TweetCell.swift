//
//  TweetCell.swift
//  CombineDemo
//
//  Created by Anvar Rahimov on 12.08.2022.
//

import Foundation
import UIKit

class TweetCell: UITableViewCell {
    let nameLabel = UILabel(text: "Username",
                            font: .boldSystemFont(ofSize: 16),
                            textColor: .black)
    let tweetTextLabel = UILabel(text: "Tweet Text MultiLines",
                                 font: .systemFont(ofSize: 16),
                                 textColor: .darkGray,
                                 numberOfLines: 0)
    let profileImageView = UIImageView(image: nil,
                                       contentMode: .scaleAspectFill)
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.borderWidth = 0.5
        hstack(
            profileImageView.withSize(.init(width: 50, height: 50)),
            stack(nameLabel, tweetTextLabel, spacing: 8),
            spacing: 20,
            alignment: .top
        ).withMargins(.allSides(24))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
