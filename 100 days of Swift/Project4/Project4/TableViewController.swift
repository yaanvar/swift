//
//  TableViewController.swift
//  Project4
//
//  Created by Anvar Rahimov on 18.01.2022.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["reddit.com", "youtube.com", "github.com", "vk.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SimpleBrowser"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewController {
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}

