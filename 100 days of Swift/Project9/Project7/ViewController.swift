//
//  ViewController.swift
//  Project7
//
//  Created by Anvar Rahimov on 02.02.2022.
//

import UIKit

class ViewController: UITableViewController {
    var storedPetitions = [Petition]()
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Petitions in US"
        
        
        if navigationController?.tabBarItem.tag == 0 {
            self.urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            self.urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(showFilter))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showFilter() {
        let ac = UIAlertController(title: "Filter", message: "Enter the keywords to filter petitions (Leave empty to reset filters)", preferredStyle: .alert)
        ac.addTextField()
        let filterAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let keyword = ac?.textFields?[0].text else { return }
            self?.filter(keyword)
        }
        ac.addAction(filterAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func filter(_ keyword: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.filteredPetitions = []
            for petition in self?.petitions ?? [] {
                if keyword == "" {
                    self?.petitions = self?.storedPetitions ?? []
                    self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
                    return
                }
                if petition.body.contains(keyword) || petition.title.contains(keyword) {
                    self?.filteredPetitions.append(petition)
                }
            }
            self?.petitions = self?.filteredPetitions ?? []
            
            self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; Please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            storedPetitions = petitions
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false) 
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

