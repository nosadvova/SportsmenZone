//
//  ErrorItem.swift
//  
//
//  Created by Vova Novosad on 07.04.2024.
//

import Foundation

public struct ErrorItem: Identifiable {
  public var id = UUID()
  public let localizedError: LocalizedError

  public init(id: UUID = UUID(), localizedError: LocalizedError) {
    self.id = id
    self.localizedError = localizedError
  }
}

public protocol LocalizedError {
  var title: String { get }
  var message: String { get }
}
