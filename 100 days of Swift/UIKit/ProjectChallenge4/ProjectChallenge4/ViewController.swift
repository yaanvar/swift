//
//  ViewController.swift
//  ProjectChallenge4
//
//  Created by Anvar Rahimov on 10.02.2022.
//

import UIKit

class ViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var album = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Album"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        let defaults = UserDefaults.standard
        if let savedAlbum = defaults.object(forKey: "album") as? Data {
            do {
                album = try JSONDecoder().decode([Photo].self, from: savedAlbum)
            } catch {
                print("failed to load album")
            }
        }
    }
    
    @objc func addPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        save()
        
        present(picker, animated: true)
    }
    
    func save() {
        if let savedData = try? JSONEncoder().encode(album) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "album")
        } else {
            print("failed to encode album")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumenDirectory().appendingPathComponent(imageName)
        
        if let jpedData = image.jpegData(compressionQuality: 0.8) {
            try? jpedData.write(to: imagePath)
        }
        
        let photo = Photo(image: imageName, name: "Unknown")
        album.append(photo)
        
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        cell.textLabel?.text = album[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.photo = album[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.album.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            self.save()
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in
            let ac = UIAlertController(title: "Change name", message: "Enter new name for photo", preferredStyle: .alert)
            ac.addTextField()
            let changeName = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
                guard let newName = ac?.textFields?[0].text else { return }
                self?.album[indexPath.row].name = newName
                self?.save()
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
            ac.addAction(changeName)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(ac, animated: true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipeActions
    }

}

