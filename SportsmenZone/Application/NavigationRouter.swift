//
//  NavigationRouter.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.02.2024.
//

import SwiftUI

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedTab: AppScreen = .mainTabView
    
    public func back(_ steps: Int = 1) {
        path.removeLast(steps)
    }
    
    public func replace(with routes: [Route]) {
        path = NavigationPath()
        for route in routes {
            path.append(route)
        }
    }
    
    public func replace(with route: Route) {
        path = NavigationPath()
        path.append(route)
    }
    
    public func push(_ route: Route) {
        path.append(route)
    }
}
