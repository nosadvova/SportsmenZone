//
//  SportsmenZoneApp.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 18.02.2024.
//

import SwiftUI

@main
struct SportsmenZoneApp: App {
    @ObservedObject private var routerManager = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routerManager.path) {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        route
                            .navigationBarBackButtonHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                    }
            }
            .toolbar(.hidden)
            .environmentObject(routerManager)
        }
    }
}
