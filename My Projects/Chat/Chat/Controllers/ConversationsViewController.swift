//
//  ConversationsViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}

class ConversationsViewController: UIViewController {
    
    //MARK: - UI
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.isHidden = true
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: ConversationTableViewCell.identifier)
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
    
    var conversations = [Conversation]()

    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNoConversationsLabel()
        setupTableView()
        fetchConversations()
        startListeningForConversations()
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
        newConversationViewController.completion = { [weak self] result in
            self?.createNewConversation(result: result)
        }
        let navigationController = UINavigationController(rootViewController: newConversationViewController)
        present(navigationController, animated: true)
    }
    
    private func createNewConversation(result: [String: String]) {
        guard let name = result["name"],
              let email = result["safeEmail"] else {
            return
        }
        
        let chatViewController = ChatViewController(with: email, id: model.id)
        chatViewController.isNewConversation = true
        chatViewController.title = name
        chatViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(chatViewController, animated: true)
    }

    private func startListeningForConversations() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }

        let safeEmail = DatabaseManager.safeEmail(email: email)

        DatabaseManager.shared.getAllConversations(for: safeEmail, completion: { [weak self] result in
            switch result {
            case .success(let conversations):
                guard !conversations.isEmpty else {
                    self?.tableView.isHidden = true
                    self?.noConversationsLabel.isHidden = false
                    return
                }
                self?.noConversationsLabel.isHidden = true
                self?.tableView.isHidden = false
                self?.conversations = conversations

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.tableView.isHidden = true
                self?.noConversationsLabel.isHidden = false
            }
        })
    }
    
}

// MARK: - UITableViewDelegate

extension ConversationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = conversations[indexPath.row]
        
        let viewController = ChatViewController(with: model.otherUserEmail)
        viewController.title = model.name
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ConversationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(conversations.count)
        return conversations.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let model = conversations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.identifier,
                                                 for: indexPath) as! ConversationTableViewCell
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

