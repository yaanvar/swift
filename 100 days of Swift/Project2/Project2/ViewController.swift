//
//  ViewController.swift
//  Project2
//
//  Created by Anvar Rahimov on 21.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestions = 0
    var highestScore = 0
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        // Do any additional setup after loading the view.
        
        askQuestion()
        
        self.highestScore = defaults.integer(forKey: "highestScore")
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        let ac = UIAlertController(title: "Game Over", message: "Your final score is \(score)", preferredStyle: .alert)
        
        if totalQuestions == 10 {
            if score > highestScore {
                highestScore = score
                defaults.removeObject(forKey: "highestScore")
                defaults.set(score, forKey: "highestScore")
                ac.message = "You beat your previous record! Your new record: \(score)"
                
            }
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            
            score = 0
            totalQuestions = 0
        }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].description.uppercased() + " Score: \(score)"
        
        totalQuestions += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        for button in [button1, button2, button3] {
            if button?.tag == sender.tag {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
                    button?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    button?.transform = .identity
                }
            }
        }
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's flag of \(countries[sender.tag].description.uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: nil, message: "Your score is \(score)\nYour higest score is \(highestScore)", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }
    

}

