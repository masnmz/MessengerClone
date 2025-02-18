//
//  Route.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 18/02/2025.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
