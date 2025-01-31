//
//  ProfileView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        //            header
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.systemGray4))
            Text("Bruce Wayne")
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
                    Button("Log Our") {
                        
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
    ProfileView()
}
