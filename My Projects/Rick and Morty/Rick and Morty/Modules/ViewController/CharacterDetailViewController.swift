//
//  CharacterDetailViewController.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import UIKit

//  На экране детальной информации о персонаже должно отображаться имя, раса, пол, статус, аватарка, последнее известное местоположение, кол-во эпизодов, в которых упоминался данный персонаж.

class CharacterDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    static let identifier = "CharacterDetailViewController"

    var characterID: Int?
    
    var characterItem: Character?
    
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
    
    private lazy var statusTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Status"
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Location"
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberOfMentionsInEpisodesTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Number of mentions in episodes"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        guard let characterID = characterID else {
            return
        }
        
        fetchCharacterByID(id: characterID)
        
        guard let characterItem = characterItem else {
            return
        }

        configure(with: characterItem)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        photoImageView.setRound()
        
    }
    
    //MARK: - Setup
    
    func setupView() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        view.addSubview(nameTextLabel)
        view.addSubview(speciesTextLabel)
        view.addSubview(genderTextLabel)
        view.addSubview(statusTextLabel)
        view.addSubview(locationTextLabel)
        view.addSubview(numberOfMentionsInEpisodesTextLabel)
        view.addSubview(photoImageView)
        
        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            nameTextLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            nameTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            speciesTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor),
            speciesTextLabel.leadingAnchor.constraint(equalTo: nameTextLabel.leadingAnchor),
            speciesTextLabel.trailingAnchor.constraint(equalTo: nameTextLabel.trailingAnchor),
            speciesTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            genderTextLabel.topAnchor.constraint(equalTo: speciesTextLabel.bottomAnchor),
            genderTextLabel.leadingAnchor.constraint(equalTo: nameTextLabel.leadingAnchor),
            genderTextLabel.trailingAnchor.constraint(equalTo: nameTextLabel.trailingAnchor),
            genderTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            statusTextLabel.topAnchor.constraint(equalTo: genderTextLabel.bottomAnchor),
            statusTextLabel.leadingAnchor.constraint(equalTo: nameTextLabel.leadingAnchor),
            statusTextLabel.trailingAnchor.constraint(equalTo: nameTextLabel.trailingAnchor),
            statusTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            locationTextLabel.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor),
            locationTextLabel.leadingAnchor.constraint(equalTo: nameTextLabel.leadingAnchor),
            locationTextLabel.trailingAnchor.constraint(equalTo: nameTextLabel.trailingAnchor),
            locationTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            numberOfMentionsInEpisodesTextLabel.topAnchor.constraint(equalTo: locationTextLabel.bottomAnchor),
            numberOfMentionsInEpisodesTextLabel.leadingAnchor.constraint(equalTo: nameTextLabel.leadingAnchor),
            numberOfMentionsInEpisodesTextLabel.trailingAnchor.constraint(equalTo: nameTextLabel.trailingAnchor),
            numberOfMentionsInEpisodesTextLabel.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    //MARK: - Configure view with model
    
    func configure(with model: Character) {
        nameTextLabel.text = (model.name)
        speciesTextLabel.text = "Species: \(model.species)"
        genderTextLabel.text = "Gender: \(model.gender)"
        statusTextLabel.text = "Status: \(model.status)"
        locationTextLabel.text = "Location: \(model.location.name)"
        numberOfMentionsInEpisodesTextLabel.text = "Number of mentions in episodes: \(model.episode.count)"
        photoImageView.loadImage(urlString: model.image)
    }
    
    //MARK: - Fetches
    
    func fetchCharacterByID(id: Int) {
        APICaller.shared.getCharacterBy(id: id) { [weak self] result in
            switch result {
            case .success(let characterItem):
                self?.characterItem = characterItem
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
