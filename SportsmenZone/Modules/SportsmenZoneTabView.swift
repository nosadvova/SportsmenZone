//
//  SportsmenZoneTabView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI

struct SportsmenZoneTabView: View {
    @StateObject var appViewModel = AppViewModel()
    @EnvironmentObject var routerManager: NavigationRouter
    
    var body: some View {
        TabView(selection: $routerManager.selectedTab) {
            MainPageView()
                .tabItem {
                    Label("Main Page", systemImage: "house.fill")
                }
                .tag(AppScreen.mainView)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(AppScreen.search)
            
            GymView(viewModel: GymViewModel(isHomeScreen: true))
                .tabItem {
                        Label("Gym", systemImage: "dumbbell")
                }
                .tag(AppScreen.gym)
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
                .tag(AppScreen.profile)
        }
        .environmentObject(routerManager)
        .onAppear {
            appViewModel.getUser()
        }
    }
}

enum AppScreen: String, Hashable {
    case mainTabView
    case mainView
    case search
    case gym
    case profile      
}

#Preview {
    SportsmenZoneTabView()
}
