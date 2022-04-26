//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import UIKit

// Для каждого персонажа в ячейке списка должно отображаться имя, раса, пол, аватарка.

class CharacterTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    var name: String?
    var species: String?
    var gender: String?
    var photo: UIImage?
    
    static let identifier = "CharacterTableViewCell"
    
    //MARK: - UI
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Species"
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Gender"
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Overriden
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.setRound()
        
    }

    //MARK: - Setup
    
    func setupCell() {
        contentView.addSubview(nameTextLabel)
        contentView.addSubview(speciesTextLabel)
        contentView.addSubview(genderTextLabel)
        contentView.addSubview(photoImageView)
        
        let constraints = [
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
            
            nameTextLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            nameTextLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            nameTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            speciesTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor),
            speciesTextLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            speciesTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            speciesTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            genderTextLabel.topAnchor.constraint(equalTo: speciesTextLabel.bottomAnchor, constant: -10),
            genderTextLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            genderTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            genderTextLabel.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Configure cell with model
    
    func configure(with model: Character) {
        nameTextLabel.text = (model.name)
        speciesTextLabel.text = "Species: \(model.species)"
        genderTextLabel.text = "Gender: \(model.gender)"
        photoImageView.loadImage(urlString: model.image)
    }
    
}
