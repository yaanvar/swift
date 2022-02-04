//
//  ViewController.swift
//  ProjectChallenge3
//
//  Created by Anvar Rahimov on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {
    var allWords = [String]()
    var hiddenWord: String = ""
    var hiddenWordLabel: UILabel!
    var guessesLabel: UILabel!
    var letterAnswer: UITextField!
    var scoreLabel: UILabel!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var guessesLeft = 7 {
        didSet {
            guessesLabel.text = "Guesses left: \(guessesLeft)"
        }
    }
    var usedLetter = Set<Character>()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        guessesLabel = UILabel()
        guessesLabel.translatesAutoresizingMaskIntoConstraints = false
        guessesLabel.textAlignment = .right
        guessesLabel.text = "Guesses left: \(guessesLeft)"
        view.addSubview(guessesLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .left
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
        
        hiddenWordLabel = UILabel()
        hiddenWordLabel.translatesAutoresizingMaskIntoConstraints = false
        hiddenWordLabel.textAlignment = .center
        hiddenWordLabel.font = UIFont.systemFont(ofSize: 64)
        hiddenWordLabel.text = "Hidden Word"
        view.addSubview(hiddenWordLabel)
        
        letterAnswer = UITextField()
        letterAnswer.translatesAutoresizingMaskIntoConstraints = false
        letterAnswer.textAlignment = .center
        letterAnswer.font = UIFont.systemFont(ofSize: 44)
        letterAnswer.placeholder = "Enter letter to guess"
        view.addSubview(letterAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        NSLayoutConstraint.activate([
            guessesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guessesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            guessesLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scoreLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            hiddenWordLabel.topAnchor.constraint(equalTo: guessesLabel.bottomAnchor),
            hiddenWordLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            letterAnswer.topAnchor.constraint(equalTo: hiddenWordLabel.bottomAnchor),
            letterAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterAnswer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            
            submit.topAnchor.constraint(equalTo: letterAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.topAnchor.constraint(equalTo: letterAnswer.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
        ])
        
        //guessesLabel.backgroundColor = .purple
        //scoreLabel.backgroundColor = .blue
        //hiddenWordLabel.backgroundColor = .red
        //letterAnswer.backgroundColor = .green
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWords()
        startGame()
        
    }
    
    
    
    @objc func loadWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["hangman"]
        }
        
    }
    
    @objc func startGame() {
        guard let randomWord = allWords.randomElement() else { return }
        print(randomWord)
        hiddenWord = randomWord.uppercased()
        hiddenWordLabel.text = ""
        for _ in 0..<hiddenWord.count {
            hiddenWordLabel.text! += "?"
        }
    }
    
    @objc func submitTapped() {
        guard let answer = letterAnswer.text else { return }
        guard let labelText = hiddenWordLabel.text else { return }
        
        if answer.count > 1 {
            let ac = UIAlertController(title: "Inappropriate answer!", message: "You can enter only a letter", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.letterAnswer.text = ""
            })
            present(ac, animated: true)
            
            guessesLeft -= 1
        } else if answer.count == 1 {
            var tempWord = ""
            let sizeOfUsedLetter = usedLetter.count
            
            for letter in hiddenWord {
                if letter == Character(answer) || usedLetter.contains(letter) {
                    usedLetter.update(with: letter)
                    
                    tempWord += String(letter)
                } else {
                    tempWord += "?"
                }
            }
            
            hiddenWordLabel.text = tempWord
            
            if usedLetter.count == sizeOfUsedLetter {
                guessesLeft -= 1
                
                let ac = UIAlertController(title: "Incorrect letter", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            
            letterAnswer.text = ""
        }
        
        if guessesLeft == 0 {
            let ac = UIAlertController(title: "Game Over!", message: "You lose 1 score point. Try new word.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            usedLetter.removeAll()
            
            guessesLeft = 7
            score -= 1
            startGame()
        }
        
        if !labelText.contains("?") {
            let ac = UIAlertController(title: "You won!", message: "You got 1 score point!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            usedLetter.removeAll()
            
            guessesLeft = 7
            score += 1
            startGame()
        }
        print(labelText)
        print(usedLetter)
    }

    @objc func clearTapped() {
        letterAnswer.text = ""
    }
    
}

