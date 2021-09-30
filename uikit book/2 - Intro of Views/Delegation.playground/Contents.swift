import Foundation

protocol MessageProtocol {
    // текст сообщения
    var text: String? { get set }
    // прикрепленное
    var image: Data? { get set }
    // прикрепленный
    var audio: Data? { get set }
    // прикрепленный
    var video: Data? { get set }
    // дата отправки
    var sendDate: Date { get set }
    // отправитель
    var senderID: UInt { get set }
}

struct Message: MessageProtocol {
    var text: String?
    var image: Data?
    var audio: Data?
    var video: Data?
    var sendDate: Date
    var senderID: UInt
}

protocol StatisticDelegate: AnyObject {
    func handle(message: MessageProtocol)
}

protocol MessengerProtocol {
    // массив всех сообщений
    var messages: [MessageProtocol] { get set }
    // делегат для ведения статистики
    var statisticDelegate: StatisticDelegate? { get set } // инициализатор
    init()
    // принять сообщение
    mutating func receive(message: MessageProtocol)
    // отправить сообщение
    mutating func send(message: MessageProtocol)
    // ...
    // делегат для загрузки сообщения
    var dataSource: MessengerDataSourceProtocol? { get set }
    // ...
}

class Messenger: MessengerProtocol {
    var dataSource: MessengerDataSourceProtocol?
    var messages: [MessageProtocol]
    weak var statisticDelegate: StatisticDelegate?
    required init() {
        messages = []
    }
    func receive(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // ...
        // прием сообщения
        // ...
    }
    func send(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // ...
        // отправка сообщения
        // ...
    }
    
    // ...
    weak var dataSource: MessengerDataSourceProtocol? {
        didSet {
            if let source = dataSource { messages = source.getMessages()
            }
        }
        // ...
    }
}

extension Messenger: StatisticDelegate {
    func handle(message: MessageProtocol) {
        // ...
        // обработка сообщения
        // ...
        print("обработка сообщения от User # \(message.senderID) завершена")
    }
}
    
var messenger = Messenger()
messenger.statisticDelegate = messenger.self
messenger.send(message: Message(text: "Привет!", sendDate: Date(), senderID: 1))
messenger.messages.count // 1
(messenger.statisticDelegate as! Messenger).messages.count // 1

protocol MessengerDataSourceProtocol: AnyObject {
    func getMessages() -> [MessageProtocol]
}

extension Messenger: MessengerDataSourceProtocol {
    func getMessages() -> [Message] {
        return [Message(text: "Как дела?", sendDate: Date(), senderID: 2)]
        
    }
}
