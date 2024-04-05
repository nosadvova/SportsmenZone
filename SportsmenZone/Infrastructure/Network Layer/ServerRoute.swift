//
//  ServerRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

protocol ServerRoute {
    var host: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: Data? { get }
    var pathParams: [String: String]? { get }
}

extension ServerRoute {
    var scheme: String {
        return "http://"
    }
    
    var host: String {
        return "localhost:8000/"
    }
}
