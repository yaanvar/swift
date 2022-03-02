//
//  DetailViewController.swift
//  ProjectChallenge5
//
//  Created by Anvar Rahimov on 14.02.2022.
//

import UIKit

class DetailViewController: UITableViewController {
    var country: Country?
    
    var rows: [String?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.country?.name
        
        rows = [self.country?.capital, self.country?.size, self.country?.population, self.country?.currency, self.country?.randomFact]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rows?[indexPath.row]
        return cell
    }
    

}
