//
//  User.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 01/02/2025.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? UUID().uuidString
    }
}

extension User {
    static let MockUser = User(fullname: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "batman")
}
