//
//  Route.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.02.2024.
//

import SwiftUI

enum Route {
    case login
    case registration
    case authentication(AuthenticationRoute)
    case gym(GymRoute)
}

extension Route: View {
    var body: some View {
        switch self {
        case .login:
            LoginView()
        case .registration:
            RegistrationView()
        case .authentication(let route):
            route.body
        case .gym(let route):
            route.body
        }
    }
}

extension Route: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.hashValue)
  }
}
