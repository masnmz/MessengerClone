//
//  InboxViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 05/02/2025.
//

import Foundation
import Observation
import Firebase

class InboxViewModel {
    var currentUser: User? {
        return UserService.shared.currentUser
    }
    
}
