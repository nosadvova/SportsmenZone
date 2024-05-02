//
//  ServerRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation
import CacheProvider

protocol ServerRoute {
    var host: String { get }
    var scheme: String { get }
    var port: Int? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: Data? { get }
    var authToken: String? { get }
}

extension ServerRoute {
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return "localhost"
    }
    
    var port: Int? {
        return 8000
    }
    
    var authToken: String? {
        let token: SimplifiedAuthToken? = ServiceFacade.getService(CacheProvider.self).getSensitiveValue(forKey: Constants.StorageKey.authToken)
        guard let token = token else { return nil }
        return token.token
    }
}
