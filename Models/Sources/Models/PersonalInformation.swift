//
//  File.swift
//
//
//  Created by Vova Novosad on 07.03.2024.
//

import Foundation

public enum UserType: String, Codable, Sendable {
    case Sportsman = "Sportsman"
    case Trainer = "Trainer"
}

public struct PersonalInformation: Codable, Sendable {
    public var userImage: String?
    public var firstName: String?
    public var lastName: String?
    public var password: String?
    public var email: String?
    public var userType: UserType?
    public var gym: String?
    
    
    enum CodingKeys: String, CodingKey {
        case userImage = "user_image"
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case email
        case userType = "user_type"
        case gym
    }
    
    public init(userImage: String? = nil, firstName: String? = nil, lastName: String? = nil, password: String? = nil, email: String? = nil, userType: UserType? = nil, gym: String? = nil) {
        self.userImage = userImage
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.email = email
        self.userType = userType
        self.gym = gym
    }
    
    public var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
    
    public func copy(
        userImage: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        password: String? = nil,
        email: String? = nil,
        userType: UserType? = nil,
        gym: String? = nil
    ) -> PersonalInformation {
        return PersonalInformation(
            userImage: userImage ?? self.userImage,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            password: password ?? self.password,
            email: email ?? self.email,
            userType: userType ?? self.userType,
            gym: gym ?? self.gym
        )
    }
}
