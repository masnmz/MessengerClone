//
//  SettingOptionsViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import SwiftUI

enum SettingOptionsViewModel: Int, CaseIterable, Identifiable {
    case darkMode
    case activeStatus
    case accessibility
    case privacy
    case notifications
    
    var title: String {
        switch self {
            
        case .darkMode: return "Dark Mode"
        case .activeStatus: return "Active Status"
        case .accessibility: return "Accessibility"
        case .privacy: return "Privacy"
        case .notifications: return "Notifications"
        }
    }
    
    var imageName: String {
        switch self {
        case .darkMode: return "moon.circle.fill"
        case .activeStatus: return "message.badge.circle.fill"
        case .accessibility: return "person.circle.fill"
        case .privacy: return "lock.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }
    
    var imageBackgroundColor: Color {
        switch self {
        case .darkMode: return .black
        case .activeStatus: return Color(.systemGreen)
        case .accessibility: return .black
        case .privacy: return Color(.systemBlue)
        case .notifications: return Color(.systemPurple)
        }
    }
    
    var id: Int { return self.rawValue}
}

func handleOptionSelection(_ option: SettingOptionsViewModel) {
    switch option {
    case .darkMode:
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        UserDefaults.standard.set(!isDarkMode, forKey: "isDarkMode") // Toggle Dark Mode
        
        
        
    case .privacy:
        print("Navigate to Privacy Settings")
        // Open privacy settings
        
    case .notifications:
        print("Navigate to Notifications Settings")
        // Open notifications settings
        
    case .activeStatus:
        print("Do it later")
    case .accessibility:
        print("Do it later")
        
    }
}
