//
//  RealGymAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 22.04.2024.
//

import Foundation
import Models

class RealGymAPI: NetworkService, GymAPI {
    func createGym(gymInformation: Gym) async throws {
        return try await sendRequest(route: GymNetworkRoute.createGym(gymInformation: gymInformation))
    }
    
    func getGym(id: String) async throws {
        return try await sendRequest(route: GymNetworkRoute.getGym(id: id))
    }
    
    func getAllGyms() async throws {
        return try await sendRequest(route: GymNetworkRoute.getAllGyms)
    }
}
