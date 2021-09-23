//
//  SecondViewController.swift
//  Right on target
//
//  Created by Anvar Rahimov on 23.09.2021.
//

import UIKit

class SecondViewController: UIViewController {
    

    
    override func loadView() {
        super.loadView()
        print("loadView SecondViewController")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad SecondViewController")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear SecondViewController")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear SecondViewController")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear SecondViewController")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear SecondViewController")
    }
}
