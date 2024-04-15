//
//  RealAuthenticationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 31.03.2024.
//

import Foundation
import Models

class RealAuthenticationAPI: NetworkService, AuthenticationAPI {
    
    func register(personalInformation: UserInformationModel) async throws -> AuthToken {
        return try await sendRequest(route: AuthenticationNetworkRoute.register(personalInformation: personalInformation))
    }
    
    func login(email: String, password: String) async throws -> AuthToken {
        return try await sendRequest(route: AuthenticationNetworkRoute.login(email: email, password: password))
    }
}
