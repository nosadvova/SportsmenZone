//
//  AuthorizationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation
import Models

protocol AuthenticationAPI {
  func register(personalInformation: UserInformationModel) async throws -> AuthToken
  func login(email: String, password: String) async throws -> AuthToken
}
