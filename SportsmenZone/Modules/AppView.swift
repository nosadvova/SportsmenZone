//
//  ContentView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 18.02.2024.
//

import SwiftUI

struct AppView: View {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isUserAuth {
                SportsmenZoneTabView()
                    .onAppear {
                        viewModel.getUser()
                    }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    AppView()
}
