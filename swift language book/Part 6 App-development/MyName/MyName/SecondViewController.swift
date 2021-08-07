//
//  SecondViewController.swift
//  MyName
//
//  Created by Anvar Rahimov on 06.08.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBAction func changeLabelText(_ sender: UIButton) {
        if let buttonText = sender.titleLabel!.text {
            self.myLabel.text = "\(buttonText) button was pressed"
        }
    }
    
    @IBAction func showAlert() {
        let alertController = UIAlertController(
            title: "Welcome",
            message: "This is MyName app",
            preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        
        let buttonOK = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        let buttonCancel = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        alertController.addAction(buttonOK)
        alertController.addAction(buttonCancel)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
