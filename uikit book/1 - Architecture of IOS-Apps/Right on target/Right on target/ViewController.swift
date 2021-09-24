//
//  ViewController.swift
//  Right on target
//
//  Created by Anvar Rahimov on 20.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // Игра
    var game: Game!
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!

    //MARK: - Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // инициализируем игру
        game = Game(valueGenerator: NumberGenerator(startValue: 1, endValue: 50)!, rounds: 5)
        // обновляем данные о текущем значении
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    //MARK: - Взаимодействие View - Model
    
    
    @IBAction func checkNumber() {
        // высчитываем очки за раунд
        game.currentRound.calculateScore(with: Int(slider.value))
        // проверяем окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
        } else {
            game.startNewRound()
        }
        // обновляем данные о текущем значении заданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    //MARK: - Обновление View
    
    // обновление текста загаданного числа
    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }
    
    // отображения всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
            title: "Game Over!",
            message: "You've got \(score) points",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

