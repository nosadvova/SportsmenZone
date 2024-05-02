//
//  File.swift
//  
//
//  Created by Vova Novosad on 08.04.2024.
//

import Foundation

public struct UserInformationModel: Encodable {
    public var firstName: String?
    public var lastName: String?
    public var password: String?
    public var email: String?
    public var userType: String?
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case email
        case userType = "user_type"
    }
    
    public init(firstName: String? = nil, lastName: String? = nil, password: String? = nil, email: String? = nil, userType: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.email = email
        self.userType = userType
    }
}
