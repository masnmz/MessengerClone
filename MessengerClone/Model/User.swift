//
//  User.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 01/02/2025.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = UUID()
    let fullname: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MockUser = User(fullname: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "batman")
}
