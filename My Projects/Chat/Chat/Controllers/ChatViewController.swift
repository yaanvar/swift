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
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
}

extension MessageKind {
    var messageKindString: String {
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributedText"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "linkPreview"
        case .custom(_):
            return  "custom"
        }
    }
}

struct Sender: SenderType {
    public var photoURL: String
    public var senderId: String
    public var displayName: String
}

class ChatViewController: MessagesViewController {
    
    //MARK: - Properties
    
    public static let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    public var isNewConversation = false
    public var conversationId: String?
    public var otherUserEmail: String
    
    private var messages = [Message]()
    
    private var sender: Sender? = {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        
        return Sender(photoURL: "",
                      senderId: email ,
                      displayName: "Joe Smith")
    }()

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
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        messageInputBar.inputTextView.becomeFirstResponder()
    }
    
    
    //MARK: - Settings
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }

}

//MARK: - InputBar

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
            guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
                let sender = self.sender,
                let messageId = createMessageId() else {
                    return
            }

            print("Sending: \(text)")

            let message = Message(sender: sender,
                                   messageId: messageId,
                                   sentDate: Date(),
                                   kind: .text(text))

            if isNewConversation {
                DatabaseManager.shared.createNewConversation(with: otherUserEmail, name: self.title ?? "User", firstMessage: message, completion: { [weak self]success in
                    if success {
                        print("message sent")
                        self?.isNewConversation = false
                        let newConversationId = "conversation_\(message.messageId)"
                        self?.conversationId = newConversationId
                        self?.messageInputBar.inputTextView.text = nil
                    }
                    else {
                        print("faield ot send")
                    }
                })
            }
            else {
                guard let conversationId = self.conversationId,
                      let name = self.title else {
                    return
                }
                
                DatabaseManager.shared.sendMessage(to: conversationId, message: message, completion: { [weak self] success in
                    if success {
                        self?.messageInputBar.inputTextView.text = nil
                        print("message sent")
                    }
                    else {
                        print("failed to send")
                    }
                })
            }
        }

        private func createMessageId() -> String? {
            guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
                return nil
            }

            let safeCurrentEmail = DatabaseManager.safeEmail(email: currentUserEmail)

            let dateString = Self.dateFormatter.string(from: Date())
            let newIdentifier = "\(otherUserEmail)_\(safeCurrentEmail)_\(dateString)"

            print("created message id: \(newIdentifier)")

            return newIdentifier
        }
}

//MARK: - MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return sender ?? Sender(photoURL: "", senderId: "42", displayName: "")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}
