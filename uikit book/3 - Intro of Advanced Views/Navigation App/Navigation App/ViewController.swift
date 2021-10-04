//
//  ViewController.swift
//  Navigation App
//
//  Created by Anvar Rahimov on 04.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.prompt = "Подсказка"
        self.navigationItem.title = "Заголовок сцены"
        self.navigationItem.backButtonTitle = "Назад"
    }
    
    // Ссылка на сториборд, где размещен данный ViewController
    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    // ...
    
    // перейти к зеленой сцене
    @IBAction func toGreenScene(_ sender: UIButton) {
        // получаем ссылку на следующий контроллер
        // в данном случае следующий - это зеленый
        let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "greenViewController")
        // обращаемся к Navigation Controller
        // и вызываем метод перехода к новому контроллеру
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    // перейти к желтой сцене
    @IBAction func toYellowScene(_ sender: UIButton) {
        let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "yellowViewController")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    // перейти к корневой сцене
    @IBAction func toRootScene(_ sender: UIButton) {
        // обращаемся к Navigation Controller
        // и вызываем метод перехода к корневому контроллеру
        self.navigationController?.popToRootViewController(animated: true)
    }


}

