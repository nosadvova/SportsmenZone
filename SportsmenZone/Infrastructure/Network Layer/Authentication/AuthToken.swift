//
//  AuthToken.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

public struct SimplifiedAuthToken: Codable {
    public var token: String
    public var refreshToken: String
    public var isValid: Bool
    
    public init(token: String, refreshToken: String, isValid: Bool) {
        self.token = token
        self.refreshToken = refreshToken
        self.isValid = isValid
    }
}

public struct AuthToken {
    
    public var token: String
    public var refreshToken: String
    public let expiresAt: Date
    private let createdAt: Date
    
    public init(token: String, refreshToken: String, expiresAt: Date, createdAt: Date) {
        self.token = token
        self.refreshToken = refreshToken
        self.expiresAt = expiresAt
        self.createdAt = createdAt
    }
    
    public var isValid: Bool {
        let currentDate = Date()
        return currentDate <= expiresAt
    }
}

extension AuthToken: Codable {
    enum CodingKeys: String, CodingKey {
        case token
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
        
        let expiresAtString = try container.decode(String.self, forKey: .expiresAt)
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        
        guard let expiresAtDate = DateFormatter.rfc3339.date(from: expiresAtString),
              let createdAtDate = DateFormatter.rfc3339.date(from: createdAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .expiresAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        self.expiresAt = expiresAtDate
        self.createdAt = createdAtDate
    }
}
