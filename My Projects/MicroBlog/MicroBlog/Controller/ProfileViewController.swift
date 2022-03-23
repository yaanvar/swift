//
//  ProfileViewController.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    
    var user: User?
    
    var posts: [Post] = []
    
    var currentEmail: String = {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email") else {
            return ""
        }
        return currentUserEmail
    }()
    
    //MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()

        title = currentEmail
        view.backgroundColor = .systemBackground
        
        setSignOutButton()
        setTableView()
        setTableHeader()
        fetchProfileData()
    }
    
    //MARK: - Settings
    
    func setTableHeader(profilePhotoReferrence: String? = nil, name: String? = nil) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width))
        headerView.backgroundColor = .systemBackground
        headerView.clipsToBounds = true
        headerView.isUserInteractionEnabled = true
        tableView.tableHeaderView = headerView
        
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(x: (view.width-view.width/2)/2, y: (headerView.height-view.width/2)/5, width: view.width / 2, height: view.width / 2)
        profilePhoto.isUserInteractionEnabled = true
        headerView.addSubview(profilePhoto)
        let tap = UITapGestureRecognizer(target: self, action: #selector(profilePhotoTapped))
        profilePhoto.addGestureRecognizer(tap)
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.width / 2
        
        let emailLabel = UILabel(frame: CGRect(x: 20, y: profilePhoto.bottom+30, width: view.width-40, height: 100))
        emailLabel.text = currentEmail
        emailLabel.textAlignment = .center
        emailLabel.font = .systemFont(ofSize: 25, weight: .bold)
        headerView.addSubview(emailLabel)
        
        if let name = name {
            title = name
        }
        
        if let referrence = profilePhotoReferrence {
            StorageManager.shared.downloadURLForProfilePicture(path: referrence) { url in
                guard let url = url else {
                    return
                }
                
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else {
                        return
                    }

                    DispatchQueue.main.async {
                        print("to")
                        profilePhoto.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
        }
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
    }
    
    //MARK: - Sign Out
    
    func setSignOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(signOutTapped))
    }
    
    @objc func signOutTapped() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive) { _ in        AuthenticationManager.shared.signOut { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")

                        let navigationController = UINavigationController(rootViewController: SignInViewController())
                        navigationController.navigationBar.prefersLargeTitles = true
                        navigationController.modalPresentationStyle = .fullScreen
                        self?.present(navigationController, animated: true, completion: nil)
                    }
                }
            }
            
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    //MARK: - Functions
    
    func fetchProfileData() {
        DatabaseManager.shared.getUser(email: currentEmail) { [weak self] user in
            guard let user = user else{
                return
            }
            DispatchQueue.main.async {
                self?.setTableHeader(profilePhotoReferrence: nil, name: user.name)
            }
        }
    }
    
    @objc func profilePhotoTapped() {
        guard let myEmail = UserDefaults.standard.string(forKey: "email"),
              myEmail == currentEmail else {
            return
        }
        
        self.presentPhotoActionSheet()
    }

}

//MARK: - TableView

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let postViewController = PostViewController()
        postViewController.title = "Post"
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func fetchPosts() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Post number \(indexPath.row + 1)"
        return cell
    }
    
    
}

//MARK: - UIImagePickerController

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose source for profile picture:", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            self?.presentPhotoLibrary()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    func presentPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        StorageManager.shared.uploadUserProfilePicture(email: currentEmail, image: image) { [weak self] success in
            guard let strongSelf = self else {
                return
            }
            if success {
                DatabaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in
                    guard updated else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.fetchProfileData()
                    }
                }
            }
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        presentPhotoActionSheet()
    }
    
}
