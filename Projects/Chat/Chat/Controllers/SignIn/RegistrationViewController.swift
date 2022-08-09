//
//  RegistrationViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegistrationViewController: UIViewController {
    
    //MARK: - UI
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Firs Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()

        // view
        
        title = "Register"
        view.backgroundColor = .systemBackground
        
        // delegates and targets
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subview
        
        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        // gestureRecognizer
        
        profileImageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeProfileImageTapped)))
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // scrollView
        scrollView.frame = view.bounds
        
        // profileImageView
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        
        // autoLayout
        
        let constraints = [
            
            // profileImageView
            
            profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            // firstNameField
            firstNameField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            firstNameField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            firstNameField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            firstNameField.heightAnchor.constraint(equalToConstant: 52),
            
            // lastNameField
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 10),
            lastNameField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lastNameField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            lastNameField.heightAnchor.constraint(equalToConstant: 52),
            
            // emailField
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 10),
            emailField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            // passwordField
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            
            // registerButton
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            registerButton.heightAnchor.constraint(equalToConstant: 52)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Button Actions
    
    @objc private func registerButtonTapped() {
            emailField.resignFirstResponder()
            passwordField.resignFirstResponder()
            firstNameField.resignFirstResponder()
            lastNameField.resignFirstResponder()

            guard let firstName = firstNameField.text,
                let lastName = lastNameField.text,
                let email = emailField.text,
                let password = passwordField.text,
                !email.isEmpty,
                !password.isEmpty,
                !firstName.isEmpty,
                !lastName.isEmpty,
                password.count >= 6 else {
                    alertUserRegisterError()
                    return
            }

            spinner.show(in: view)

            // Firebase Sign In
            DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
                DispatchQueue.main.async {
                    self?.spinner.dismiss()
                }

                guard !exists else {
                    // user already exists
                    self?.alertUserRegisterError(message: "Looks like user with this email already exists. Please try again or sign in.")
                    return
                }

                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                    guard authResult != nil, error == nil else {
                        print("Error creating user")
                        return
                    }

                    UserDefaults.standard.setValue(email, forKey: "email")
                    UserDefaults.standard.setValue("\(firstName) \(lastName)", forKey: "name")


                    let chatUser = ChatUser(firstName: firstName,
                                            lastName: lastName,
                                            email: email)
                    
                    DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                        if success {
                            guard let image = self?.profileImageView.image,
                                let data = image.pngData() else {
                                    return
                            }
                            let filename = chatUser.profilePhotoFileName
                            StorageManager.shared.uploadProfilePhoto(with: data, fileName: filename, completion: { result in
                                switch result {
                                case .success(let downloadUrl):
                                    UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                    print(downloadUrl)
                                case .failure(let error):
                                    print("Storage maanger error: \(error)")
                                }
                            })
                        }
                    })

                    self?.navigationController?.dismiss(animated: true, completion: nil)
                })
            })
        }
    
    @objc func changeProfileImageTapped() {
        presentPhotoActionSheet()
    }
    
    //MARK: - Functions
    
    func alertUserRegisterError(message: String = "Please enter all information to register.") {
        let alertController = UIAlertController(title: "Something went wrong", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

}

//MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
}

//MARK: - UIImagePickerController

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        dismiss(animated: true)
        self.profileImageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
}
