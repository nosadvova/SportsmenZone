//
//  User.swift
//
//
//  Created by Vova Novosad on 07.03.2024.
//

import Foundation

public struct User: Codable, Sendable, Identifiable {
    public var id: String
//    public var userImage: String?
//    public var firstName: String?
//    public var lastName: String?
//    public var password: String?
//    public var email: String?
//    public var userType: UserType?
//    public var gym: String?
    public var personalInformation: PersonalInformation?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case personalInformation = "personal_information"
    }
    
    public init(id: String, personalInformation: PersonalInformation?) {
        self.id = id
        self.personalInformation = personalInformation
    }
}

public extension User {
    func copy(
        id: String? = nil,
        personalInformation: PersonalInformation? = nil
    ) -> User {
        return User(
            id: id ?? self.id,
            personalInformation: personalInformation ?? self.personalInformation
        )
    }
}
