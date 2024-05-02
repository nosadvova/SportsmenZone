//
//  ContentView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 18.02.2024.
//

import SwiftUI
//import CacheProvider

struct AppView: View {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isUserAuth {
                GymView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    AppView()
}
