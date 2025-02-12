//
//  MessageService.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 07/02/2025.
//

import Foundation
import FirebaseAuth
import Firebase

struct MessageService {
    
   static let messagesCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let chatPartnerID = user.id
        
        let currentUserRef = messagesCollection.document(currentUID).collection(chatPartnerID).document()
        let chatPartnerUserRef = messagesCollection.document(chatPartnerID).collection(currentUID)
        
        let messageID = currentUserRef.documentID
        
        let message = Message(
            messageID: messageID,
            fromID: currentUID,
            toID: chatPartnerID,
            messageText: messageText,
            timestamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerUserRef.document(messageID).setData(messageData)
        
    }
    
    static func observeMessages(chatParner: User, completion: @escaping ([Message]) -> Void) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let chatPartnerID = chatParner.id
        
        let query = messagesCollection
            .document((currentUID))
            .collection(chatPartnerID)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter( { $0.type == .added}) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where message.fromID != currentUID {
                messages[index].user = chatParner
                
            }
            completion(messages)
        }
    }
}
