//
//  AuthToken.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.03.2024.
//

import Foundation

public struct AuthToken {

  public var accessToken: String
  public var refreshToken: String
  public let expiresIn: Int
  private let createdAt: Date

  public init(accessToken: String, refreshToken: String, expiresIn: Int) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    self.expiresIn = expiresIn
    self.createdAt = Date()
  }

  public var isValid: Bool {
    return createdAt.addingTimeInterval(TimeInterval(expiresIn) - 5 * 60) >= Date()
  }
}

extension AuthToken: Codable {
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case expiresIn = "expires_in"
    case createdAt = "created_at"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.accessToken = try container.decode(String.self, forKey: .accessToken)
    self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    self.expiresIn = try container.decode(Int.self, forKey: .expiresIn)
    self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
  }
}
