//
//  GymRouter.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 10.03.2024.
//

import SwiftUI
import Models

enum GymRoute {
    case gym
    case allSportsmen
}

extension GymRoute: View {
    var body: some View {
        switch self {
        case .gym:
            GymView()
        case .allSportsmen:
            UserListView(viewModel: GymViewModel())
        }
    }
}

extension GymRoute: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
