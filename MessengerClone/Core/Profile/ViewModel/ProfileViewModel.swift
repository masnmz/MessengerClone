//
//  ProfileViewModel.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import Observation
import PhotosUI
import SwiftUI



@Observable
class ProfileViewModel: ObservableObject {
    var selectedItem: PhotosPickerItem? {
        didSet {
            Task { try await loadImage()
            }
        }
    }
    
    var profileImage: Image?
    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    
}
