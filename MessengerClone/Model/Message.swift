//
//  Message.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 07/02/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageID: String?
    let fromID: String
    let toID: String
    let messageText: String
    let timestamp: Timestamp
    
    var user: User?
    
    var id: String {
        return messageID ?? UUID().uuidString
    }
    
    var chatPartnerID: String {
        return fromID == Auth.auth().currentUser?.uid ? toID : fromID
    }
    
    var isFromCurrentUser: Bool {
        return fromID == Auth.auth().currentUser?.uid
    }
}
