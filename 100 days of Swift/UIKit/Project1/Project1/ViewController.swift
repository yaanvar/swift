//
//  ViewController.swift
//  Project1
//
//  Created by Anvar Rahimov on 18.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var viewCounters = [Int]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Strom Viewer"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadImages), with: nil)
        
        pictures.sort()
        
        print(pictures)
        
        viewCounters = defaults.object(forKey: "viewCounters") as? [Int] ?? [Int]()
    }
    
    @objc func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        if viewCounters.isEmpty {
            for _ in 0..<items.count {
                viewCounters.append(0)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "Views: \(viewCounters[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            viewCounters[indexPath.row] += 1
            tableView.reloadData()
    
            defaults.removeObject(forKey: "viewCounters")
            defaults.set(viewCounters, forKey: "viewCounters")
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Storm Viewer app"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

