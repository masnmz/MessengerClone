//
//  AuthService.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 04/02/2025.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func login(withEmail email: String, password: String) async throws {
        print("Debug: Email is \(email)")
        print("Debug: Password is \(password)")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Debug: Create user \(result.user.uid)")
        } catch {
            print("Debug: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
}
