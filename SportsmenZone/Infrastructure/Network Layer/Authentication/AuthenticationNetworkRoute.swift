//
//  AuthenticationRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

enum AuthenticationNetworkRoute {
  case register(email: String, otp: String)
  case login(email: String, otp: String)
//  case refreshAuthToken(String)
}

extension AuthenticationNetworkRoute: ServerRoute {    
    var pathParams: [String : String]? {
        return nil
    }
    
    
    var path: String {
        switch self {
        case .register:
            return "users/register"
        case .login:
            return "users/login"
//        case .refreshAuthToken:
//            return "oauth/access-token"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case let .register(email, otp):
            struct Request: Encodable {
                let email: String
                let otp: String
            }
            
            return Request(email: email, otp: otp).requestBody()
            
        case let .login(email, otp):
            struct Request: Encodable {
                let email: String
                let password: String
            }
            
            return Request(email: email, password: otp).requestBody()
            
//        case let .refreshAuthToken(refreshToken):
//            struct Request: Codable {
//                let grantType = "refresh_token"
//                let refreshToken: String
//                
//                enum CodingKeys: String, CodingKey {
//                    case grantType = "grant_type"
//                    case refreshToken = "refresh_token"
//                }
//            }
            
//            return Request(refreshToken: refreshToken).requestBody()
        }
    }
}
