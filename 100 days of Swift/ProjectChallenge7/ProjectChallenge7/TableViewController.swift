//
//  TableViewController.swift
//  ProjectChallenge7
//
//  Created by Anvar Rahimov on 20.02.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var notes: [Note] = [] {
        didSet {
            save()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        
        if let data = UserDefaults.standard.value(forKey: "notes") as? Data {
            if let noteData = try? PropertyListDecoder().decode(Array<Note>.self, from: data) {
                notes = noteData
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        save()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        save()
        tableView.reloadData()
    }
    
    @objc func createNote() {
        let indexPath = IndexPath(row: (notes.count), section: 0)
        notes.append(Note(title: "New note", body: ""))
        tableView.insertRows(at: [indexPath], with: .automatic)
            
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteView") as? NoteViewController {
            vc.note = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(notes), forKey:"notes")
    }

    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteView") as? NoteViewController {
            vc.note = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

