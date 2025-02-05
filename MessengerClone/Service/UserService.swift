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
    
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: Current user in service is \(String(describing: currentUser))")
    }
    
}
