//
//  ChatService.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 12/02/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct ChatService {
    
    let chatPartner: User
    
    
     
      func sendMessage(_ messageText: String) {
         guard let currentUID = Auth.auth().currentUser?.uid else { return }
         let chatPartnerID = chatPartner.id
         
          let currentUserRef = FireStoreConstants.messagesCollection.document(currentUID).collection(chatPartnerID).document()
          let chatPartnerUserRef = FireStoreConstants.messagesCollection.document(chatPartnerID).collection(currentUID)
         
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
     
      func observeMessages(completion: @escaping ([Message]) -> Void) {
         guard let currentUID = Auth.auth().currentUser?.uid else { return }
         let chatPartnerID = chatPartner.id
         
          let query = FireStoreConstants.messagesCollection
             .document((currentUID))
             .collection(chatPartnerID)
             .order(by: "timestamp", descending: false)
         
         query.addSnapshotListener { snapshot, _ in
             guard let changes = snapshot?.documentChanges.filter( { $0.type == .added}) else { return }
             var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
             
             for (index, message) in messages.enumerated() where message.fromID != currentUID {
                 messages[index].user = chatPartner
                 
             }
             completion(messages)
         }
     }
    
}
