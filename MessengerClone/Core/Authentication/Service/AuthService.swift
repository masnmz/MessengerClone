//
//  AuthService.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 04/02/2025.
//

import SwiftUI
import FirebaseAuth
import Observation

@Observable
class AuthService {
    
    var userSession: FirebaseAuth.User?
    
    static var authStateStream: AsyncStream<FirebaseAuth.User?> {
            AsyncStream { continuation in
                let listener = Auth.auth().addStateDidChangeListener { _, user in
                    continuation.yield(user)
                }
                continuation.onTermination = { _ in
                    Auth.auth().removeStateDidChangeListener(listener)
                }
            }
        }
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session id is \(String(describing: userSession?.uid))")
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
        } catch {
            print("Debug: Failed to sign in user with error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("Debug: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out on backend
            self.userSession = nil // updates routing logic
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
}
