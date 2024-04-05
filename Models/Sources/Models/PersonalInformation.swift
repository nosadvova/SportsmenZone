//
//  File.swift
//
//
//  Created by Vova Novosad on 07.03.2024.
//

import Foundation

public struct PersonalInformation: Codable, Sendable {
    public var userImage: String?
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var userType: UserType?
    
    
    enum CodingKeys: String, CodingKey {
        case userImage
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case userType = "user_type"
    }
    
    public init(userImage: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, userType: UserType? = nil) {
        self.userImage = userImage
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userType = userType
    }
    
    public var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
    
    public func copy(
        userImage: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        userType: UserType? = nil
    ) -> PersonalInformation {
        return PersonalInformation(
            userImage: userImage ?? self.userImage,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            email: email ?? self.email,
            userType: userType ?? self.userType
        )
    }
}
