//
//  View.swift
//  VIPER
//
//  Created by Anvar Rahimov on 17.08.2022.
//

import Foundation
import UIKit

// ViewController
// Protocol
// Reference to presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: AnyPresenter?
    
    var users: [User] = []
    
    func update(with users: [User]) {
        print("got users")
        DispatchQueue.main.async { [weak self] in
            self?.users = users
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.users = []
            self?.tableView.isHidden = true
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        errorLabel.frame = CGRect(x:  0, y: 0, width: 200, height: 50)
        errorLabel.center = view.center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}
