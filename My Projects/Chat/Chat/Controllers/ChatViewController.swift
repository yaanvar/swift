//
//  ChatViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 13.03.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender: SenderType {
    var photoURL: String
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    
    //MARK: - Properties
    
    public var isNewConversation = false
    public var otherUserEmail: String
    
    private var messages = [Message]()
    
    private let sender = Sender(photoURL: "", senderId: "1", displayName: "Joe Smith")

    //MARK: - Initializer
    
    init(with email: String) {
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messages.append(Message(sender: sender, messageId: "1", sentDate: Date(), kind: .text("Hello!")))
        messages.append(Message(sender: sender, messageId: "1", sentDate: Date(), kind: .text("Hi!")))
        
        setupView()
        
    }
    

    func setupView() {
        view.backgroundColor = .systemBackground
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }

}

//MARK: - MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return self.sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}
