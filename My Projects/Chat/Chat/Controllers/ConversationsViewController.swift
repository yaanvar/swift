//
//  ConversationsViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {
    
    //MARK: - UI
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.isHidden = true
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var noConversationsLabel: UILabel = {
       let label = UILabel()
        label.text = "No Conversations"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    //MARK: - Properties
    
    var data = ["Hello World"]

    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNoConversationsLabel()
        setupTableView()
        fetchConversations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }

    //MARK: - Firebase
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            showSignInViewController()
        }
    }
    
    //MARK: - Settings
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeButtonTapped))
    }
    
    func setupNoConversationsLabel() {
        view.addSubview(noConversationsLabel)
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
    
    //MARK: - Fetch Conversations
    
    private func fetchConversations() {
        tableView.isHidden = false
    }
    
    //MARK: - Functions
    
    @objc func composeButtonTapped() {
        let newConversationViewController = NewConversationViewController()
        let navigationController = UINavigationController(rootViewController: newConversationViewController)
        present(navigationController, animated: true)
    }

}

// MARK: - UITableViewDelegate

extension ConversationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = ChatViewController()
        viewController.title = "Joe Smith"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ConversationsViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
}

