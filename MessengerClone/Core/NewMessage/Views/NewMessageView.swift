//
//  NewMessageView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @State private var viewModel = NewMessageViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Binding var selectedUser: User?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .background(isDarkMode ? Color(.systemGray5) : Color(.systemGroupedBackground)) // Background should be applied before clipping
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .padding(.leading) // External padding
                
                Text("Contacts")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(viewModel.users) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    
    NavigationStack {
        NewMessageView(selectedUser: .constant(User.MockUser))
    }
}
