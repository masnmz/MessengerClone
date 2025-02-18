//
//  ActiveNowViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 18/02/2025.
//

import Foundation

@Observable
class ActiveNowViewModel {
    var users = [User]()
    
    init() {
        Task { try await fetchUsers()}
    }
    
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchAllUsers(limit: 10)
    }
}
