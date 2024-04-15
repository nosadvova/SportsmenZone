//
//  AuthenticationRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation
import Models

enum AuthenticationNetworkRoute {
    case register(personalInformation: UserInformationModel)
    case login(email: String, password: String)
}

extension AuthenticationNetworkRoute: ServerRoute {
    var path: String {
        switch self {
        case .register:
            return "/users/register"
        case .login:
            return "/users/login"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var header: [String: String]? {
        //        var headers: [String: String] = [:]
        //        headers["Content-Type"] = "application/json"
        return nil
    }
    
    var body: Data? {
        switch self {
        case let .register(personalInformation):
            return personalInformation.requestBody()
            
        case let .login(email, password):
            struct Request: Encodable {
                let email: String
                let password: String
            }
            
            return Request(email: email, password: password).requestBody()
        }
    }
}
