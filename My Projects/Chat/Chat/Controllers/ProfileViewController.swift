//
//  ProfileViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)

    //MARK: - Properties
    
    let data = ["Log Out"]
    
    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        setupView()
        setupTableView()
    }
    
    //MARK: - Settings
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableViewHeader()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func createTableViewHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        
        let safeEmail = DatabaseManager.safeEmail(email: email)
        let fileName = safeEmail + "_profile_photo.png"
        
        let path = "images: "+fileName
        
        let headerView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.view.bounds.width,
                                        height: 300))
        let imageView = UIImageView(frame: CGRect(x: (headerView.frame.width - 150) / 2,
                                                  y: 75,
                                                  width: 150,
                                                  height: 150))
    
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        headerView.backgroundColor = .link
        headerView.addSubview(imageView)
    
        StorageManager.shared.downloadURL(for: path) { [weak self] result in
            switch result {
            case .success(let url):
                self?.downloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("Failed to get download URL: \(error)")
            }
        }
        
        return headerView
    }
    
    func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }.resume()
    }

}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                self?.showSignInViewController(withAnimation: true)
            } catch {
                print("Fail to sign out")
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
}
