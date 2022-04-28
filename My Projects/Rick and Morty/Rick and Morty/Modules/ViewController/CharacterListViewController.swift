//
//  CharacterListViewController.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Properties
    
    var characters = [Character]()
    
    var currentPage = 1
    var pageInfo: Info?

    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        setupTableView()
        fetchAllCharacters()
        fetchPageInfo(from: APICaller.Constants.allCharactersString)
        
    }
    
    //MARK: - Setup
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        title = "Rick and Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let goBack = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(previousPage))
        let goForward = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: self, action: #selector(nextPage))
        toolbarItems = [goBack, spacer, goForward]
        navigationController?.isToolbarHidden = false
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Fetches
    
    func fetchPageWithCharacters(from urlString: String) {
        APICaller.shared.getPageWithCharacters(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAllCharacters() {
        APICaller.shared.getAllCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPageInfo(from pageURLString: String) {
        APICaller.shared.getPageInfo(pageURLString: pageURLString) { [weak self] result in
            switch result {
            case .success(let info):
                self?.pageInfo = info
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - nextPage and previousPage
    
    @objc func nextPage() {
        
        guard let nextPageURLString = pageInfo?.next else {
            return
        }
        
        fetchPageWithCharacters(from: nextPageURLString)
        fetchPageInfo(from: nextPageURLString)
        
        tableView.reloadData()
    }
    
    @objc func previousPage() {
        
        guard let previousPageURLString = pageInfo?.prev else {
            return
        }
        
        fetchPageWithCharacters(from: previousPageURLString)
        fetchPageInfo(from: previousPageURLString)
        
        tableView.reloadData()
    }


}

//MARK: - UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let characterDetailViewController = CharacterDetailViewController()
        characterDetailViewController.characterID = characters[indexPath.row].id
        navigationController?.pushViewController(characterDetailViewController, animated: true)
        
    }
    
}

//MARK: - UITableViewDataSource

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = characters[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterTableViewCell.identifier,
            for: indexPath
        )
        
        guard let characterCell = cell as? CharacterTableViewCell else {
            cell.backgroundColor = .orange
            return cell
        }
        
        characterCell.configure(with: model)
        
        characterCell.accessoryType = .disclosureIndicator
        
        return characterCell
    }
}
