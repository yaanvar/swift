//
//  ProfileViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)

    //MARK: - Properties
    
    let data = ["Log Out"]
    
    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        setupView()
        setupTableView()
    }
    
    //MARK: - Settings
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
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

}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                self?.showSignInViewController(withAnimation: true)
            } catch {
                print("Fail to sign out")
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
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
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
}
