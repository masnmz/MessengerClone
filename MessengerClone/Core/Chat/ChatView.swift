//
//  ChatView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 01/02/2025.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView {
                //            header
                VStack {
                    CircularProfileImageView(user: User.MockUser, size: .xLarge)
                    
                    VStack(spacing: 4) {
                        Text("Bruce Wayne")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    
                }
                //            messages
                
                ForEach(0...15, id: \.self) { message in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
                
            }
            //            message inout view
            Spacer()
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    print("Send message")
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
