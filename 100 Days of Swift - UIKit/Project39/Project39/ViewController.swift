//
//  ViewController.swift
//  Project39
//
//  Created by Anvar Rahimov on 11.03.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Properties
    
    var playData = PlayData()

    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playData.filteredWords = ["Neener!"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    //MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.allWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let word = playData.allWords[indexPath.row]
        cell.textLabel!.text = word
        cell.detailTextLabel!.text = "\(playData.wordCounts[word]!)"
        return cell
    }
    
    //MARK: - Functions
    
    @objc func searchTapped() {
        let ac = UIAlertController(title: "Filter…", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Filter", style: .default) { [unowned self] _ in
            let userInput = ac.textFields?[0].text ?? "0"
            self.playData.applyUserFilter(userInput)
            self.tableView.reloadData()
        })

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(ac, animated: true)
    }

}

