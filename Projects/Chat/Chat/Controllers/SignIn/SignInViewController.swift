//
//  SignInViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class SignInViewController: UIViewController {
    
    //MARK: - UI
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
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
    
    private let signIn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
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
        
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector((registerButtonTapped)))
        
        // delegates and targets
        
        signIn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subview
        
        view.addSubview(scrollView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(signIn)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // scrollView
        scrollView.frame = view.bounds
        
        // autoLayout
        
        let constraints = [
            
            // emailField
            emailField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            emailField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            // passwordField
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            
            // registerButton
            signIn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            signIn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signIn.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            signIn.heightAnchor.constraint(equalToConstant: 52)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Button Actions
    
    @objc func signInButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserSignInError()
            return
        }
        
        spinner.show(in: view)
        
        // firebase sign in
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async { [weak self] in
                self?.spinner.dismiss()
            }
            
            guard let result = authResult, error == nil else {
                print("Error occured while signing in")
                return
            }
            
            let user = result.user
            
            UserDefaults.standard.set(email, forKey: "email")
            
            print("User signed in: \(user)")
            
            self?.navigationController?.dismiss(animated: true)
        }
    }
    
    @objc func registerButtonTapped() {
        let viewController = RegistrationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Functions
    
    func alertUserSignInError() {
        let alertController = UIAlertController(title: "Something went wrong", message: "Please enter all information to sign in.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

}

//MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            signInButtonTapped()
        }
        
        return true
    }
}
