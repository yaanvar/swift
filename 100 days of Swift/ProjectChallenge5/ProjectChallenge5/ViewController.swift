//
//  ViewController.swift
//  ProjectChallenge5
//
//  Created by Anvar Rahimov on 14.02.2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title
        navigationController?.navigationBar.prefersLargeTitles =  true
        title = "Countries"
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                parse(json: data)
            }
        }
        
        
    }
    
    // MARK: - Parsing
    
    func parse(json: Data) {
        if let jsonCountries = try? JSONDecoder().decode(Countries.self, from: json) {
            countries = jsonCountries.results
            tableView.reloadData()
        }
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

