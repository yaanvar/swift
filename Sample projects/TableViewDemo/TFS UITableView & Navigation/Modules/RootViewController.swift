//
//  RootViewController.swift
//  TFS UITableView & Navigation
//
//  Created by Sergey Shalnov on 28.02.2022.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Properties
    
    private let countries = Country.mock
    
    // MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        
        // 1
        tableView.register(
            UINib(nibName: String(describing: CityTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: CityTableViewCell.identifier
        )
        
        // 2
        tableView.dataSource = self
        tableView.delegate = self
        
        // 3
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56
        
        //4
        navigationItem.title = "Countries"
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
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

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(TargetViewController(), animated: true)
    }
}

// MARK: - UITableViewDataSource

extension RootViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries[section].cities.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.identifier,
            for: indexPath
        )
        
        guard let cityCity = cell as? CityTableViewCell else {
            cell.backgroundColor = .orange
            return cell
        }
        
        let country = countries[indexPath.section]
        let city = country.cities[indexPath.row]
        
        cityCity.accessoryType = .detailButton
        cityCity.titleLabel?.text = city
        cityCity.subtitleLabel?.text = country.name
        
        return cityCity
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(#function, indexPath)
    }
}
