//
//  AuthToken.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

public struct AuthToken {

  public var token: String
  public var refreshToken: String
//  public let expiresAt: Date
//  private let createdAt: Date

    public init(token: String, refreshToken: String) {
    self.token = token
    self.refreshToken = refreshToken
//    self.expiresAt = expiresAt
//    self.createdAt = createdAt
  }
}

extension AuthToken: Codable {
  enum CodingKeys: String, CodingKey {
    case token
    case refreshToken = "refresh_token"
//    case expiresAt = "expires_at"
//    case createdAt = "created_at"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.token = try container.decode(String.self, forKey: .token)
    self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
//    self.expiresAt = try container.decode(Date.self, forKey: .expiresAt)
//    self.createdAt = try container.decode(Date.self, forKey: .createdAt)
  }
}
