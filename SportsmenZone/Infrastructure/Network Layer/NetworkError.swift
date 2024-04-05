//
//  APIError.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

enum NetworkError: Error {
    case decode
    case generic
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode Error"
        case .generic:
            return "Generic Error"
        case .invalidURL:
            return "Invalid URL Error"
        case .noResponse:
            return "No Response"
        case .unauthorized:
            return "Unauthorized URL"
        case .unexpectedStatusCode:
            return "Status Code Error"
        default:
            return "Unknown Error"
        }
    }
}
