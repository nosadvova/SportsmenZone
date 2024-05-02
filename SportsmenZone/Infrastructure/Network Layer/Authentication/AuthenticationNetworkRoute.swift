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
    case login(personalInformation: UserInformationModel)
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
        return nil
    }
    
    var body: Data? {
        switch self {
        case let .register(personalInformation):
            struct Request: Encodable {
                let personalInformation: UserInformationModel
                
                enum CodingKeys: String, CodingKey {
                    case personalInformation = "personal_information"
                }
            }
            return Request(personalInformation: personalInformation).requestBody()
            
        case let .login(personalInformation):
            struct Request: Encodable {
                let personalInformation: UserInformationModel
                
                enum CodingKeys: String, CodingKey {
                    case personalInformation = "personal_information"
                }
            }
            
            return Request(personalInformation: personalInformation).requestBody()
        }
    }
}
