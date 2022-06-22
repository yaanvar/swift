//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by Anvar Rahimov on 13.05.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - UI
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        
    }
    
    //MARK: - Setup
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }

    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        
    
    }
    
}

