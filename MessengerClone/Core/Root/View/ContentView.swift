//
//  ContentView.swift
//  MessengerClone
//
//  Created by Mehmet Alp Sönmez on 31/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                InboxView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
