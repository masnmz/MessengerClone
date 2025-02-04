//
//  ContentViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 04/02/2025.
//

import FirebaseAuth
import Observation
import Combine

@Observable
class ContentViewModel {
    var userSession: FirebaseAuth.User?
    private let authService = AuthService()
    
    init() {
        Task {
            await observeAuthChanges()
        }
        
    }
    
    private func observeAuthChanges() async {
        for await user in AuthService.authStateStream {
            self.userSession = user
        }
    }
}
