//
//  LoginViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 04/02/2025.
//

import SwiftUI
import Observation

@Observable
class LoginViewModel {
    
    var email = ""
    var password = ""
    
    func login() async throws {
        try await AuthService().login(withEmail: email, password: password)
    }
    
}
