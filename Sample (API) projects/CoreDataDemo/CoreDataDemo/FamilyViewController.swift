//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Anvar Rahimov on 12.05.2022.
//

import UIKit
import CoreData

class FamilyViewController: UIViewController {
    
    //MARK: - CoreData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Properties
    
    var items: [Person]?
    
    //MARK: - UI
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        
        fetchPeople()
        
    }
    
    //MARK: - Setup
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Family"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFamilyMember))
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Functions
    
    @objc func addFamilyMember() {
        let alertController = UIAlertController(title: "Add new family member", message: "Please enter name, gender and age of new family member.", preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields?[0].placeholder = "Name"
        alertController.textFields?[1].placeholder = "Gender"
        alertController.textFields?[2].placeholder = "Age"
        
        alertController.addAction(UIAlertAction(title: "Add",
                                                style: .default,
                                                handler: { [weak alertController] _ in
            // getting data from textfields
            let name = alertController?.textFields?[0].text
            let gender = alertController?.textFields?[1].text
            let age = Int64(alertController?.textFields?[2].text ?? "0")!
            
            // creating person object
            let newPerson = Person(context: self.context)
            newPerson.name = name
            newPerson.gender = gender
            newPerson.age = age
            
            // saving data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            // refresh data
            self.fetchPeople()
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alertController, animated: true)
    }
    
    //MARK: - Relationship demo
    
    func relationshipDemo() {
        
        // create family
        let family = Family(context: context)
        family.name = "Abc Family"
        
        // create person
        let person = Person(context: context)
        person.name = "Maggie"
        //person.family = family
        
        // add members
        family.addToMembers(person)
        
        // save context
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    //MARK: - Fetch
    
    func fetchPeople() {
        do {
            
            let request = Person.fetchRequest()
            
            // filtering and sorting
            
            //let predicate = NSPredicate(format: "genfer CONTAINS %@", "Ted")
            //request.predicate = predicate
            
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            
            // fetching
            self.items = try context.fetch(request)
            
            // reload ui
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
}

//MARK: - UITableViewDelegete, UITableViewDataSource

extension FamilyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        let person = items?[indexPath.row]
        
        cell.textLabel?.text = person?.name
        cell.detailTextLabel?.text = "\(String(describing: person?.gender)), \(String(describing: person?.age)) years old"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { [self] action, view, completionHandler in
            // get data for removal
            let personToRemove = items![indexPath.row]
            
            // delete data
            self.context.delete(personToRemove)
            
            // save data
            do {
                try context.save()
            } catch {
                print(error)
            }
            
            // reload data
            fetchPeople()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let alertController = UIAlertController(title: "Edit information about person", message: "Please edit name, gender and age of family member.", preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        let person = items![indexPath.row]
        alertController.textFields?[0].text = person.name
        alertController.textFields?[1].text = person.gender
        alertController.textFields?[2].text = "\(person.age)"
        
        alertController.addAction(UIAlertAction(title: "Save",
                                                style: .default,
                                                handler: { [weak alertController] _ in
            // getting data from textfields
            let name = alertController?.textFields?[0].text
            let gender = alertController?.textFields?[1].text
            let age = Int64(alertController?.textFields?[2].text ?? "0")!
            
            // creating person object
            person.name = name
            person.gender = gender
            person.age = age
            
            // saving data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            // refresh data
            self.fetchPeople()
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alertController, animated: true)
    }

}
