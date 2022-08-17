//
//  UsersViewController.swift
//  MyAppUIKit
//
//  Created by Anvar Rahimov on 17.08.2022.
//

import UIKit

public protocol DataFetchable {
    func fetchUsersNames(completion: @escaping (([String]) -> Void))
}

struct User: Codable {
    let name: String
}

public class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dataFetchbale: DataFetchable
    
    var users: [User] = []
    
    public init(dataFetchable: DataFetchable) {
        self.dataFetchbale = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        dataFetchbale.fetchUsersNames { [weak self] names in
            self?.users = names.map({ User(name: $0) })
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        print(users)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }


}
