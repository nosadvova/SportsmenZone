//
//  RealAuthenticationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 31.03.2024.
//

import Foundation

class RealAuthenticationAPI: NetworkService, AuthenticationAPI {
    func register(email: String, otp: String) async throws -> AuthToken {
        return try await sendRequest(route: AuthenticationNetworkRoute.register(email: email, otp: otp))
    }
    
    func login(email: String, otp: String) async throws -> AuthToken {
        return try await sendRequest(route: AuthenticationNetworkRoute.login(email: email, otp: otp))
    }
}
