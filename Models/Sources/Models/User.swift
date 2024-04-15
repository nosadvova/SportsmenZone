//
//  User.swift
//
//
//  Created by Vova Novosad on 07.03.2024.
//

import Foundation

public struct User: Codable, Sendable, Identifiable {
    public var id: String
    public var personalInformation: PersonalInformation?
    
    enum CodingKeys: String, CodingKey {
        case id
        case personalInformation = "personal_information"
    }
    
    public init(id: String, personalInformation: PersonalInformation? = nil) {
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
