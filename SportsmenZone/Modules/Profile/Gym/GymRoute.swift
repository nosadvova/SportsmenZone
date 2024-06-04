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
    case notifications
    case training(isOwner: Bool)
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
        case .notifications:
            NotificationView()
        case .training(let isOwner):
            TrainingView(viewModel: TrainingViewModel(isOwner: isOwner))
        }
    }
}

extension Gym: Equatable {
    public static func ==(lhs: Gym, rhs: Gym) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension GymRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
