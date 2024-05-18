//
//  GymNetworkRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 22.04.2024.
//

import Foundation
import Models

enum GymNetworkRoute {
    case createGym(gymInformation: Gym)
    case getGym(id: String)
    case getAllGyms
    case followGym(id: String)
}

extension GymNetworkRoute: ServerRoute {
    var path: String {
        switch self {
        case .createGym:
            "/gym"
        case .getGym(let id):
            "/gym/\(id)"
        case .getAllGyms:
            "/gym"
        case .followGym(let id):
            "/gym/\(id)/follow"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createGym, .followGym:
            return .post
        case .getGym, .getAllGyms:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .createGym(let gymInformation):
            return gymInformation.requestBody()
        case .getGym, .getAllGyms:
            return nil
        case .followGym:
            return nil
        }
    }
}
