//
//  RegistrationViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 04/02/2025.
//

import SwiftUI
import Observation

@Observable
class RegistrationViewModel {
    var email = ""
    var password = ""
    var fullName = ""
    
    func creayeUser() async throws {
        try await AuthService().createUser(withEmail: email, password: password, fullName: fullName)
    }
}
