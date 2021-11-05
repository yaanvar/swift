//
//  BoardGameController.swift
//  Cards
//
//  Created by Anvar Rahimov on 05.11.2021.
//

import UIKit

class BoardGameController: UIViewController {
    
    //MARK: - Model to Controller
    
    // количество пар уникальных карточек
    var cardsPairsCounts = 8
    // сущность "игра"
    lazy var game: Game = getNewGame()
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = cardsPairsCounts
        game.generateCards()
        return game
    }
    
    //MARK: - Cards
    
    // генерация массива карточек на основе модели
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        // хранилище для представления карточек
        var cardViews = [UIView]()
        // фабрика карточек
        let cardViewFactory = CardViewFactory()
        
        // перебираем массив карточек в модели
        for (index, modelCard) in modelData.enumerated() {
            // добавляем первый экземпляр карты
            let cardOne = cardViewFactory.get(modelCard.type, withSize:
            cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            // добавляем второй экземпляр карты
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { flippedCard in
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)
            }
        }
        
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { [self] flippedCard in
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)

                // добавляем или удаляем карточку
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }
                
                // если перевернуто 2 карточки
                if self.flippedCards.count == 2 {
                    // получаем карточки из данных модели
                    let firstCard = game.cards[self.flippedCards.first!.tag]
                    let secondCard = game.cards[self.flippedCards.last!.tag]
                    
                    // если карточки одинаковые
                    if game.checkCards(firstCard, secondCard) {
                        // сперва анимировано скрываем их
                        UIView.animate(withDuration: 0.3, animations: {
                            self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0
                            // после чего удаляем из иерархии
                        }, completion: {_ in
                            self.flippedCards.first!.removeFromSuperview()
                            self.flippedCards.last!.removeFromSuperview()
                            self.flippedCards = []
                        })
                    // в ином случае
                    } else {
                        // переворачиваем карточки рубашкой вверх
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
            }
        }
                                                                        
        return cardViews
    }
    
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    // предельные координаты размещения карточки
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
    // игральные карточки
    var cardViews = [UIView]()
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        // удаляем все имеющиеся на игровом поле карточки
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        // перебираем карточки
        for card in cardViews {
            // для каждой карточки генерируем случайные координаты
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            // размещаем карточку на игровом поле
            boardGameView.addSubview(card)
        }
    }
    
    private var flippedCards = [UIView]()
    
    
    
    //MARK: - Controller
    
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    
    private func getStartButtonView() -> UIButton {
        // 1 - создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // 2 - изменяем положение кнопки
        button.center.x = view.center.x
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        button.frame.origin.y = topPadding
        // 3 - настраиваем внешний вид кнопки
        button.setTitle("Начать игру", for: .normal)
        button.setTitleColor(.black, for: .normal) // не нажат
        button.setTitleColor(.gray, for: .highlighted) // нажат
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        // 4 - подключаем обработку к нажатию
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc func startGame(_ sender: UIButton) {
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
    }
    
    // игровое поле
    lazy var boardGameView = getBoardGameView()
    
    private func getBoardGameView() -> UIView {
        let margin: CGFloat = 10
        
        let boardView = UIView()
        // x
        boardView.frame.origin.x = margin
        // y
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        // расчитываем ширину
        boardView.frame.size.width = UIScreen.main.bounds.width - margin*2
        // рассчитываем высоту c учетом нижнего отступа
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding

        // изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        
        return boardView
    }
    
    //MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(startButtonView)
        view.addSubview(boardGameView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
