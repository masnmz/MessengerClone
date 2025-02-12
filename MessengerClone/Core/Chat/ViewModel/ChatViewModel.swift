//
//  ChatViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 07/02/2025.
//

import SwiftUI
import Observation


@Observable
class ChatViewModel {
    var messageText = ""
    var messages = [Message]()
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages() {
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)
                                                            
                                                    
        }
    }
    
    func sendMessages() {
        service.sendMessage(messageText)
    }
}
