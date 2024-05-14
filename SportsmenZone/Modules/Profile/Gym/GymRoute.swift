//
//  GymRouter.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 10.03.2024.
//

import SwiftUI
import Models

enum GymRoute {
    case gym(gym: Gym?, isHomeScreen: Bool)
    case allSportsmen(gym: Gym?)
}

extension GymRoute: View {
    var body: some View {
        switch self {
        case .gym(let gym, let isHomeScreen):
            if let gym = gym {
                GymView(viewModel: GymViewModel(gym: gym, isHomeScreen: isHomeScreen))
            } else {
                GymView(viewModel: GymViewModel(isHomeScreen: isHomeScreen))
            }
        case .allSportsmen(let gym):
            UserListView(viewModel: GymViewModel(gym: gym))
        }
    }
}

extension Gym: Equatable {
    public static func ==(lhs: Gym, rhs: Gym) -> Bool {
        return lhs.id == rhs.id
    }
}

extension GymRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
