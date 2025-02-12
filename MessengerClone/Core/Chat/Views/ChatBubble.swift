//
//  ChatBubbleView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 01/02/2025.
//

import SwiftUI

struct ChatBubble: Shape {
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                            byRoundingCorners: [
                                .topLeft,
                                .topRight,
                                isFromCurrentUser ? .bottomLeft : .bottomRight
                                ],
                            cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
        
        
    }
}

#Preview {
    ChatBubble(isFromCurrentUser: true)
}
