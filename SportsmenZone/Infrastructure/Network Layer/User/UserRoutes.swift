//
//  UserRoutes.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.04.2024.
//

import Foundation
import CacheProvider

enum UserNetworkRoute {
    case getUser
}

extension UserNetworkRoute: ServerRoute {
    var path: String {
        return "/users/me"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
