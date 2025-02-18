//
//  InboxViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 05/02/2025.
//

import Foundation
import Observation
import Firebase

@Observable
@MainActor
class InboxViewModel {
    var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    var recentMessages: [Message] = []
    
    private let inboxService = InboxService()
    
    init() {
        Task {
            await observeMessages()
        }
    }
    
    func observeMessages() async {
        for await changes in inboxService.documentChangesStream() {
            loadInitialMessages(fromChanges: changes)
        }
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
        
        for i in 0..<messages.count {
            let message = messages[i]
            
            UserService.fetchUser(withUid: message.chatPartnerID) { user in
                messages[i].user = user
                self.updateRecentMessages(with: messages[i])
            }
        }
    }
    
    private func updateRecentMessages(with newMessage: Message) {
        // Check if message already exists
        if let index = recentMessages.firstIndex(where: { $0.chatPartnerID == newMessage.id }) {
            // Update existing message
            recentMessages[index] = newMessage
        } else {
            // Append only if it does not exist
            recentMessages.append(newMessage)
        }
        
        // Ensure only the latest message per chat partner remains
            recentMessages = recentMessages.reduce(into: [Message]()) { uniqueMessages, message in
                if let existingIndex = uniqueMessages.firstIndex(where: { $0.chatPartnerID == message.chatPartnerID }) {
                    // Keep only the latest message per chat partner
                    if message.timestamp.dateValue() > uniqueMessages[existingIndex].timestamp.dateValue() {
                        uniqueMessages[existingIndex] = message
                    }
                } else {
                    uniqueMessages.append(message)
                }
            }

        // Sort messages by timestamp
        recentMessages.sort { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }

}

