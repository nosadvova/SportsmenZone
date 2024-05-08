//
//  SportsmenZoneTabView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 28.02.2024.
//

import SwiftUI

struct SportsmenZoneTabView: View {
    var body: some View {
        TabView {
            MainPageView()
                .tabItem {
                    Label("Main Page", systemImage: "house.fill")
                }
            
            GymView()
                .tabItem {
                        Label("Gym", systemImage: "dumbbell")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    SportsmenZoneTabView()
}
