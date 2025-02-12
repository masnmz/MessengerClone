//
//  Constants.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 12/02/2025.
//

import Foundation
import Firebase
import FirebaseFirestore

struct FireStoreConstants {
    static let userCollection = Firestore.firestore().collection("users")
    static let messagesCollection = Firestore.firestore().collection("messages")
}
