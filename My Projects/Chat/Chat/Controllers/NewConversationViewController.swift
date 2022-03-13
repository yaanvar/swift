//
//  NewConversationViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    
    //MARK: - UI
    
    private let spinner = JGProgressHUD()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for users"
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.isHidden = true
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Results"
        label.isHidden = true
        label.textAlignment = .center
        label.textColor = .link
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()

    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSearchBar()
        setupTableView()
    }
    
    //MARK: - Settings
    
    func setupView() {
        view.backgroundColor = .white
        
        searchBar.becomeFirstResponder()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Functions
    
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }

}

//MARK: - UISearchBar

extension NewConversationViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}

// MARK: - UITableViewDelegate

extension NewConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = ChatViewController()
        viewController.title = "Joe Smith"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension NewConversationViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}

