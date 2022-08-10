//
//  SignInViewController.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: - UI
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Up", style: .done, target: self, action: #selector((signUpButtonTapped)))
        
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
            
            // signInButton
            signIn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            signIn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signIn.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60),
            signIn.heightAnchor.constraint(equalToConstant: 52)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Button Actions
    
    @objc func signInButtonTapped() {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            return
        }

        AuthenticationManager.shared.signIn(email: email, password: password) { [weak self] success in
            guard success else {
                return
            }

            DispatchQueue.main.async {
                UserDefaults.standard.set(email, forKey: "email")
                let tabBarViewController = TabBarViewController()
                tabBarViewController.modalPresentationStyle = .fullScreen
                self?.present(tabBarViewController, animated: true)
            }
        }
    }
    
    @objc func signUpButtonTapped() {
        let viewController = SignUpViewController()
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

