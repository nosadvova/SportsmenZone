//
//  UserAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.04.2024.
//

import Foundation
import Models

protocol UserAPI {
    func getUser() async throws -> User
}
