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
    
    //MARK: - UI
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.setRound()
        
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Overriden
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameTextLabel)
        contentView.addSubview(speciesTextLabel)
        contentView.addSubview(genderTextLabel)
        contentView.addSubview(photoImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let constraints = [
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
            
            nameTextLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            nameTextLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 10),
            nameTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            nameTextLabel.heightAnchor.constraint(equalToConstant: 10),
            
            speciesTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 5),
            speciesTextLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 10),
            speciesTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            speciesTextLabel.heightAnchor.constraint(equalToConstant: 10),
            
            genderTextLabel.topAnchor.constraint(equalTo: speciesTextLabel.bottomAnchor),
            genderTextLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 10),
            genderTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            genderTextLabel.heightAnchor.constraint(equalToConstant: 10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    //MARK: - Setup
    
    func setupCell(with model: Character) {
        
    }
    
}
