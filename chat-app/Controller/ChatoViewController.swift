//
//  ChatoViewController.swift
//  chat-app
//
//  Created by Aida Pourshirazi on 3/30/21.
//

import UIKit
import MessageKit

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

struct Sender :SenderType {
    var senderId: String
    var displayName: String
}

class ChatoViewController: MessagesViewController {
    
    private var message = [Message]()
    
    private let SelfSender = Sender( senderId:"1",
                                     displayName: "Amber P")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.append(Message (sender: SelfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("Hello This is Aida's First chat app nice to meet you")))
        
        message.append(Message (sender: SelfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("yes this is a longer buble from the other bubble message which we try to display in this demo, so we can see it")))

        view.backgroundColor = .red
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

        
        
        
        
        
    }
}
    
extension ChatoViewController : MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
   
    func currentSender() -> SenderType {
        return SelfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return message[indexPath.section]
        
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return message.count
    }
}
