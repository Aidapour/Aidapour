//
//  mymessageview.swift
//  chat-app
//
//  Created by Aida Pourshirazi on 3/28/21.
//

import UIKit
import MessageKit


class ChatViewController: MessagesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
extension ChatViewController: MessagesDataSource {

        func currentSender() -> SenderType {
            return Sender(senderId: "any_unique_id", displayName: "Steven")
        }

        func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
            return messages.count
        }

        func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
            return messages[indexPath.section]
        }
    }

}





