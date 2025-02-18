//
//  InboxView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import SwiftUI

struct InboxView: View {
    @State private var showingMessageView = false
    @State private var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
                
                List {
                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                        .padding(.horizontal, 4)
                    
                        ForEach(viewModel.recentMessages) { message in
                            ZStack {
                                NavigationLink(value: message) {
                                    EmptyView()
                                }.opacity(0.0)
                                
                                InboxRowView(message: message)
                            }
                        
                    }
                }
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle())
                
            .onChange(of: selectedUser) { _ , newValue in
                showChat = newValue != nil
            }
            .navigationDestination(for: Message.self) { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            }
            
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chatView(let user):
                    ChatView(user: user)
                }
            }
            .navigationDestination(isPresented: $showChat) {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            }
            
            .fullScreenCover(isPresented: $showingMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                if let imageUrl = user.profileImageUrl, !imageUrl.isEmpty {
                                    CircularProfileImageView(user: user, size: .xSmall)
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(Color(.systemGray4))
                                }
                            }

                        }
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
