//
//  UserService.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 05/02/2025.
//

import Foundation
import Observation
import FirebaseAuth
import FirebaseFirestore
@Observable
class UserService {
    var currentUser: User?
    
    static let shared = UserService()
    
    private func observeAuthChanges() async {
        for await authUser in AuthService.authStateStream {
            if let uid = authUser?.uid {
                do {
                    try await fetchCurrentUser()
                } catch {
                    print("DEBUG: Failed to fetch user: \(error.localizedDescription)")
                }
            } else {
                self.currentUser = nil // User logged out
            }
        }
    }
    
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: Current user in service is \(String(describing: currentUser))")
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot, error == nil,
                  let user = try? snapshot.data(as: User.self) else {
                print("DEBUG: Failed to fetch user for uid \(uid)")
                return
            }
            completion(user)
        }
    }

}
