//
//  RealAuthenticationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 31.03.2024.
//

import Foundation
import Models

class RealAuthenticationAPI: NetworkService, AuthenticationAPI {
    
    func register(personalInformation: UserInformationModel) async throws {
        return try await sendRequest(route: AuthenticationNetworkRoute.register(personalInformation: personalInformation))
    }
    
    func login(personalInformation: UserInformationModel) async throws -> AuthToken {
        return try await sendRequest(route: AuthenticationNetworkRoute.login(personalInformation: personalInformation))
    }
}
