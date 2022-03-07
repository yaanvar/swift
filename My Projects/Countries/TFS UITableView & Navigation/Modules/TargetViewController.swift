//
//  TargetViewController.swift
//  TFS UITableView & Navigation
//
//  Created by Sergey Shalnov on 02.03.2022.
//

import UIKit

final class TargetViewController: UIViewController {
    private lazy var button = UIButton(
        configuration: .plain(),
        primaryAction: UIAction(
            handler: { [weak self] _ in
                if let navigationController = self?.navigationController {
                    navigationController.popViewController(animated: true)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Title"
        
        view.addSubview(button)
        view.backgroundColor = .systemBackground
        
        button.setTitle("Dismiss UIViewController", for: .normal)
        button.layer.cornerRadius = 20
        button.layer.cornerCurve = .continuous
        
        let constraints = [
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 56)
        ]
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
