//
//  NewMessageViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 05/02/2025.
//

import Foundation
import Observation
import FirebaseAuth

@Observable
class NewMessageViewModel {
    var users = [User]()
    
    init() {
        Task { try await fetchUsers()}
    }
    
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter { $0.uid != currentUid }
    }
}
