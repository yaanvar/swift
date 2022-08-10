//
//  NewConversationViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import JGProgressHUD
import CoreTelephony

class NewConversationViewController: UIViewController {
    
    //MARK: - Properties
    
    private var users = [[String: String]]()
    private var hasFetched = false
    private var results = [[String: String]]()
    
    public var completion: (([String:String]) -> Void)?
    
    //MARK: - UI
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for users"
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
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
        setupNoResultsLabel()
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
    
    func setupNoResultsLabel() {
        view.addSubview(noResultsLabel)
        
        let constraints = [
            noResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noResultsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            noResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noResultsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
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
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }

        searchBar.resignFirstResponder()

        results.removeAll()
        spinner.show(in: view)

        self.searchUsers(query: text)
    }

    func searchUsers(query: String) {
        if hasFetched {
            filterUsers(with: query)
        } else {
            DatabaseManager.shared.getAllUsers { [weak self] result in
                switch result {
                case .success(let usersCollection):
                    self?.hasFetched = true
                    self?.users = usersCollection
                    self?.filterUsers(with: query)
                case .failure(let error):
                    print("Failed to get users: \(error)")
                }
            }
        }
    }
    
    func filterUsers(with term: String) {
        guard hasFetched else {
            return
        }
        
        let results: [[String: String]] = self.users.filter {
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            
            return name.hasPrefix(term.lowercased())
        }
        
        self.results = results
        
        updateUI()
    }
    
    func updateUI() {
        self.spinner.dismiss()
        
        if results.isEmpty {
            self.noResultsLabel.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.noResultsLabel.isHidden = true
            self.tableView.isHidden = false
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension NewConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let targetUserData = results[indexPath.row]
        dismiss(animated: true) { [weak self] in
            self?.completion?(targetUserData)
        }
    }
}

// MARK: - UITableViewDataSource

extension NewConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]["name"]
        
        return cell
    }
}

