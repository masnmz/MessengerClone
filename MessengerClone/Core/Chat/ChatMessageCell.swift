//
//  ChatMessageCell.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 01/02/2025.
//

import SwiftUI

struct ChatMessageCell: View {
    let isFromCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text("This is a text message for now which is a longer message and let's what happends")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: User.MockUser, size: .xxSmall)
                    
                    Text("This is a text message for now which is a longer message and let's what happends")
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.74, alignment: .leading)
                    
                    Spacer()
                }
                
            }
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: false)
}
