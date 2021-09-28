//
//  ColorViewController.swift
//  Right on target
//
//  Created by Anvar Rahimov on 28.09.2021.
//

import UIKit

import UIKit

class ColorViewController: UIViewController {
    
    // экземпляр игры с цветами
    var game: Game<SecretColorValue>!
    
    // номер "правильной" кнопки
    var correctButtonTag: Int = 0
    
    // текстовая метка для вывода HEX
    @IBOutlet var hexLabel: UILabel!
    
    // кнопки для выбора цвета
    @IBOutlet var buttonColor1: UIButton!
    @IBOutlet var buttonColor2: UIButton!
    @IBOutlet var buttonColor3: UIButton!
    @IBOutlet var buttonColor4: UIButton!
    
    // вспомогательное свойство, позволяющее работать с аутлетами кнопок, как с коллекцией
    var buttonsCollection: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonsCollection = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        // обновляем View
        updateScene()
    }
    
    private func updateScene() {
        let secretColorString = game.secretValue.value.getByHEXString()
        updateSecretColorLabel(withText: secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    // MARK: - Взаимодействие View - Model
    
    // проверка выбранного пользователем цвета
    @IBAction func compareValue(sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
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
        updateScene()
    }
    
    // MARK: - Обновление View
    
    // обновление текста загаданного цвета
    private func updateSecretColorLabel(withText newHEXColorText: String ) {
        hexLabel.text = "#\(newHEXColorText)"
    }
    
    // обновление фонового цвета кнопок
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        // определяем, какая кнопка будет правильной
        correctButtonTag = Array(1...4).randomElement()!
        buttonsCollection.forEach { button in
            if button.tag == correctButtonTag {
                button.backgroundColor = secretValue.value.getByUIColor()
            } else {
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
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
