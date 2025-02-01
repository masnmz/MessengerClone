//
//  InboxRowView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: User.MockUser, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Heath Ledger")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("Some test message for now that spans more than one line")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            HStack {
                Text("Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
        
    }
}

#Preview {
    InboxRowView()
}
