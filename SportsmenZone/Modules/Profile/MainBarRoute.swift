//
//  MainBarRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 09.05.2024.
//

import SwiftUI
import Models

enum MainBarRoute {
    case mainTabView
    case mainView
    case search
    case gym
    case profile
}

extension MainBarRoute: View {
    var body: some View {
        switch self {
        case .mainTabView:
            SportsmenZoneTabView()
        case .mainView:
            MainPageView(viewModel: AppViewModel())
        case .search:
            SearchView()
        case .gym:
            GymView(viewModel: GymViewModel())
        case .profile:
            AccountView()
        }
    }
}

extension MainBarRoute: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
