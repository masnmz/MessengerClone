//
//  ProfileView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import PhotosUI
import SwiftUI


struct ProfileView: View {
    @State var viewModel = ProfileViewModel()
    let user: User
    
    var body: some View {
        //            header
        VStack {
            PhotosPicker(selection: $viewModel.selectedItem){
                if let profileImage = viewModel.profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        
                } else {
                    CircularProfileImageView(user: user, size: .xLarge)
                }
            }
            
            Text(user.fullname)
                .font(.title)
                .fontWeight(.semibold)
            //            list
            
            List {
                Section {
                    ForEach(SettingOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(option.imageBackgroundColor)
                            Text(option.title)
                                .font(.headline)
                            
                        }
                    }
                }
                
                Section {
                    Button("Log Out") {
                        AuthService().signOut()
                    }
                    
                    Button("Delete Account") {
                        
                    }
                }
                .foregroundStyle(Color(.systemRed))
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MockUser)
}
