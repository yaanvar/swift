//
//  AddCommentsViewController.swift
//  Project33
//
//  Created by Anvar Rahimov on 03.03.2022.
//

import UIKit

class AddCommentsViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Data
    
    var genre: String!
    
    //MARK: - UI

    var comments: UITextView!
    let placeholder = "If you have any additional comments that might help identify your tune, enter them here."
    
    //MARK: - Overriden
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        comments = UITextView()
        comments.translatesAutoresizingMaskIntoConstraints = false
        comments.delegate = self
        comments.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(comments)

        comments.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        comments.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        comments.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
        comments.text = placeholder
    }
    
    //MARK: - Selector functions
    
    @objc func submitTapped() {
        let vc = SubmitViewController()
        vc.genre = genre

        if comments.text == placeholder {
            vc.comments = ""
        } else {
            vc.comments = comments.text
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - TextView
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }

}
