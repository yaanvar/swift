//
//  ConversationTableViewCell.swift
//  Chat
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import UIKit
import SDWebImage

class ConversationTableViewCell: UITableViewCell {
    
    //MARK: - Properties

    static let identifier = "ConversationTableViewCell"
    
    //MARK: - UI

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()

    private let userMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Overriden

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userMessageLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 100,
                                     height: 100)

        userNameLabel.frame = CGRect(x: 110 + 10,
                                     y: 10,
                                     width: contentView.bounds.width - 20 - 100,
                                     height: (contentView.bounds.height-20)/2)

        userMessageLabel.frame = CGRect(x: 110 + 10,
                                        y: userNameLabel.bounds.height + 10 + 10,
                                        width: contentView.bounds.width - 20 - userImageView.bounds.width,
                                        height: (contentView.bounds.height-20)/2)

    }
    
    //MARK: - Settings

    public func configure(with model: Conversation) {
        userMessageLabel.text = model.latestMessage.text
        userNameLabel.text = model.name

        let path = "images/\(model.otherUserEmail)_profile_picture.png"
        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):

                DispatchQueue.main.async {
                    self?.userImageView.sd_setImage(with: url, completed: nil)
                }

            case .failure(let error):
                print("failed to get image url: \(error)")
            }
        })
    }

}
