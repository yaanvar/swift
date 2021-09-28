//
//  NumberViewController.swift
//  Right on target
//
//  Created by Anvar Rahimov on 20.09.2021.
//

import UIKit

class NumberViewController: UIViewController {
    
    // экземпляр игры с числами
    var game: Game<SecretNumericValue>!
    
    // элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var secretValueLabel: UILabel!
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    // MARK: - Взаимодействие View - Model
    
    // проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // высчитываем очки за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // проверяем, окончена ли игра
        if game.isGameEnded {
            // показываем окно с итогами
            showAlertWith(score: game.score)
            // рестартуем игру
            game.restartGame()
        } else {
            // начинаем новый раунд игры
            game.startNewRound()
        }
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    // MARK: - Обновление View
    
    // обновление текста загаданного числа
    func updateLabelWithSecretNumber(newText: String ) {
        secretValueLabel.text = newText
    }
    
    // отображение всплывающего окна со счетом
    private func showAlertWith( score: Int ) {
        let alert = UIAlertController(
                        title: "Игра окончена",
                        message: "Вы заработали \(score) очков",
                        preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
