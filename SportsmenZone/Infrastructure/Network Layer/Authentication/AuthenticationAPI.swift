//
//  AuthorizationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

protocol AuthenticationAPI {
  func register(email: String, otp: String) async throws -> AuthToken
  func login(email: String, otp: String) async throws -> AuthToken

//  func refreshAuthToken(refreshToken: String) async throws -> AuthToken
}
