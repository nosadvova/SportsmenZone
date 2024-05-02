//
//  RealUsserAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.04.2024.
//

import Foundation
import Models

class RealUserAPI: NetworkService, UserAPI {
    func getUser() async throws -> User {
        return try await sendRequest(route: UserNetworkRoute.getUser)
    }
}
