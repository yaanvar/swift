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
    
    lazy var yellowBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.yellow
        box.layer.cornerRadius = 40
        box.layer.masksToBounds = true
        box.layer.borderWidth = 2
        box.layer.borderColor = UIColor.red.cgColor
        box.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(boxDidTap))
        box.addGestureRecognizer(tapGesture)
        return box
    }()
    
    var orangeBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.orange
        box.layer.cornerRadius = 20
        box.layer.masksToBounds = true
        return box
    }()
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        //runConventionalAutoLayout()
        //setupGestures()
        
        runSnapKitAutoLayout()
        
        //setupTableView()
        
    }
    
    //MARK: - Setup
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(yellowBox)
        view.addSubview(orangeBox)
        
    }
    
    func runConventionalAutoLayout() {
        yellowBox.translatesAutoresizingMaskIntoConstraints = false
        
        yellowBox.widthAnchor.constraint(equalToConstant: 80).isActive = true
        yellowBox.heightAnchor.constraint(equalToConstant: 80).isActive = true
        yellowBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yellowBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func runSnapKitAutoLayout() {
        yellowBox.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.center.equalTo(view.snp.center)
        }
        
        orangeBox.snp.makeConstraints { make in
            make.width.equalTo(yellowBox.snp.width).multipliedBy(0.5)
            make.height.equalTo(orangeBox.snp.width)
            make.center.equalTo(yellowBox.snp.center)
        }
    }
    
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(boxDidTap))
        yellowBox.addGestureRecognizer(tapGesture)
    }
    
    @objc func boxDidTap() {
        print("did tap!")
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
    }
    
}

