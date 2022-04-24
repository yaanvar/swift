//
//  CharacterListViewController.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    //MARK: - Properties
    
    var characters: [Character]
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICaller.shared.getAllCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters = response
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    //MARK: - Setup
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}

//MARK: - UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

//MARK: - UITableViewDataSource

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
    }
    
}

