//
//  User.swift
//
//
//  Created by Vova Novosad on 07.03.2024.
//

import Foundation

public enum UserType: String, Codable, Sendable {
    case sportsmen = "Sportsmen"
    case trainer = "Trainer"
}

public struct User: Codable, Sendable, Identifiable {
    public var id: String
    public var personalInformation: PersonalInformation?
    public var userImage: String?
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var userType: UserType?
    
    enum CodingKeys: String, CodingKey {
        case id
        case personalInformation = "personal_information"
        case userImage = "user_image"
        case firstName = "first_name"
        case lastName = "last_name"
        case userType = "user_type"
        case email
    }
    
    public init(id: String, personalInformation: PersonalInformation? = nil, userImage: String? = nil, firstName: String? = nil , lastName: String? = nil, email: String? = nil, userType: UserType? = nil) {
        self.id = id
        self.personalInformation = personalInformation
        self.userImage = userImage
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userType = userType
    }
    
    public var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
}

public extension User {
    func copy(
        id: String? = nil,
        personalInformation: PersonalInformation? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        userType: UserType? = nil
    ) -> User {
        return User(
            id: id ?? self.id,
            personalInformation: personalInformation ?? self.personalInformation,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            email: email ?? self.email,
            userType: userType ?? self.userType
        )
    }
}
