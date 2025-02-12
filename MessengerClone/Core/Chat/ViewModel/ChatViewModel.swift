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
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatParner: user) { messages in
            self.messages.append(contentsOf: messages)
                                                            
                                                    
        }
    }
    
    func sendMessages() {
        MessageService.sendMessage(messageText, toUser: user)
    }
}
