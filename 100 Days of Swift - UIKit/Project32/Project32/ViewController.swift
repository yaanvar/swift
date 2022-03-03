//
//  ViewController.swift
//  Project32
//
//  Created by Anvar Rahimov on 02.03.2022.
//

import UIKit
import SafariServices
import CoreSpotlight
import MobileCoreServices

class ViewController: UITableViewController {
    
    //MARK: - Data
    
    var projects = [Project]()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading data
        
        
        projects.append(Project(name: "Project 1: Storm Viewer", description: "Constants and variables, UITableView, UIImageView, FileManager, storyboards", isFavourite: false))
        projects.append(Project(name: "Project 2: Guess the Flag", description: "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController", isFavourite: false))
        projects.append(Project(name: "Project 3: Social Media", description: "UIBarButtonItem, UIActivityViewController, the Social framework, URL", isFavourite: false))
        projects.append(Project(name: "Project 4: Easy Browser", description: "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing", isFavourite: false))
        projects.append(Project(name: "Project 5: Word Scramble", description: "Closures, method return values, booleans, NSRange", isFavourite: false))
        projects.append(Project(name: "Project 6: Auto Layout", description: "Get to grips with Auto Layout using practical examples and code", isFavourite: false))
        projects.append(Project(name: "Project 7: Whitehouse Petitions", description: "JSON, Data, UITabBarController", isFavourite: false))
        projects.append(Project(name: "Project 8: 7 Swifty Words", description: "addTarget(), enumerated(), count, index(of:), property observers, range operators.", isFavourite: false))
        
        //MARK: - UserDefaults
        
        let defaults = UserDefaults.standard

        if let savedProjects = defaults.object(forKey: "projects") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                projects = try jsonDecoder.decode([Project].self, from: savedProjects)
            } catch {
                print("Failed to load people")
            }
        }
        
        // TableView
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
    }
    
    //MARK: - TableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let project = projects[indexPath.row]
        cell.textLabel?.attributedText = makeAttributedString(title: project.name, subtitle: project.description)

        if project.isFavourite {
            cell.editingAccessoryType = .checkmark
        } else {
            cell.editingAccessoryType = .none
        }
        
        return cell
    }

    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)

        titleString.append(subtitleString)

        return titleString
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if projects[indexPath.row].isFavourite {
            return .delete
        } else {
            return .insert
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            projects[indexPath.row].isFavourite = true
            index(item: indexPath.row)
        } else {
            projects[indexPath.row].isFavourite = false
            deindex(item: indexPath.row)
        }

        save()
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(projects) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "projects")
        } else {
            print("Failed to save people.")
        }
    }
    
    func index(item: Int) {
        let project = projects[item]
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = project.name
        attributeSet.contentDescription = project.description
        
        let item = CSSearchableItem(uniqueIdentifier: "\(item)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
        item.expirationDate = Date.distantFuture
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
    }

    func deindex(item: Int) {
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(item)"]) { error in
               if let error = error {
                   print("Deindexing error: \(error.localizedDescription)")
               } else {
                   print("Search item successfully removed!")
               }
           }
    }
    
    //MARK: - SFSafariViewController
    
    func showTutorial(_ which: Int) {
        if let url = URL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}

