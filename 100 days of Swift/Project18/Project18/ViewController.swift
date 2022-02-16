//
//  ViewController.swift
//  Project18
//
//  Created by Anvar Rahimov on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(1, 2, 3, 4, 5, separator: "-", terminator: "!")
        
        assert(1 == 1, "Math failure!")
        //assert(1 == 2, "Math failure!")
        
        for i in 1...100 {
            print("Got number \(i).")
        }
    }


}

