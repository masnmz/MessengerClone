//
//  InboxService.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 14/02/2025.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

@Observable
@MainActor
class InboxService {
    var documentChanges: [DocumentChange] = []
    
    func documentChangesStream() -> AsyncStream<[DocumentChange]> {
        AsyncStream { continuation in
            guard let uid = Auth.auth().currentUser?.uid else {
                continuation.finish()
                return
            }
            
            let query = FireStoreConstants
                .messagesCollection
                .document(uid)
                .collection("recent-messages")
                .order(by: "timestamp", descending: true)
            
            let listener = query.addSnapshotListener { snapshot, _ in
                guard let changes = snapshot?.documentChanges.filter({
                    $0.type == .added || $0.type == .modified
                }) else { return }
                
                continuation.yield(changes)
            }
            
            continuation.onTermination = { _ in listener.remove() }
        }
    }
}
