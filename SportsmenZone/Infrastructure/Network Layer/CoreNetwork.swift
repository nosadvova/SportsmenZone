//
//  CoreNetwork.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

protocol CoreNetwork {
    func sendRequest<T: Decodable>(urlStr: String) async throws -> T
    func sendRequest<T: Decodable>(route: ServerRoute) async throws -> T
    func sendRequest(route: ServerRoute) async throws
}

extension CoreNetwork {
    func createRequest(route: ServerRoute) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = route.scheme
        urlComponents.host = route.host
        urlComponents.path = route.path
        urlComponents.port = route.port
        
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        if let authToken = route.authToken {
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }
//        var headers = route.header ?? [:]
//        if let authToken = route.authToken {
//            headers["Authorization"] = "\(authToken)"
//        }
        request.httpMethod = route.method.rawValue
        request.allHTTPHeaderFields = route.header
        request.httpBody = route.body
        return request
    }
}
