//
//  NotificationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 22.04.2024.
//

import Foundation
import Models

protocol NotificationAPI {
    func createGym(gymInformation: Gym) async throws -> String
    func getGym(id: String) async throws -> Gym
    func getAllGyms() async throws -> GymsResponse
    func followGym(id: String) async throws
}
