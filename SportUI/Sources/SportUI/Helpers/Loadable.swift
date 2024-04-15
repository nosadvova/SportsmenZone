//
//  Loadable.swift
//
//
//  Created by Vova Novosad on 07.04.2024.
//

import Foundation
import SwiftUI

public enum Loadable<T> {

  case notRequested
  case isLoading(last: T?)
  case loaded(T)
  case failed(id: UUID = UUID(), Error)

  public var value: T? {
    switch self {
    case let .loaded(value): return value
    case let .isLoading(last): return last
    default: return nil
    }
  }

  public var error: Error? {
    switch self {
    case let .failed(_, error): return error
    default: return nil
    }
  }
}

public extension Loadable {
  mutating func loading() {
    self = .isLoading(last: value)
  }

  var isLoading: Binding<Bool> {
    Binding {
      switch self {
      case .isLoading: return true
      default: return false
      }
    } set: { _ in }
  }

  var receivedValue: Binding<Bool> {
    Binding {
      switch self {
      case .loaded: return true
      default: return false
      }
    } set: { _ in }
  }

  func errorItem(ignore: ((Error) -> Bool)? = nil) -> Binding<ErrorItem?> {
    Binding {
      switch self {
      case let .failed(id, error):
        if let ignore, ignore(error) {
          return nil
        }

        guard let localizedError = (error as NSError) as? LocalizedError else {
          return nil
        }

        return ErrorItem(id: id, localizedError: localizedError)
      default: return nil
      }
    } set: {_ in }
  }
}

extension Loadable: Equatable where T: Equatable {
  public static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
    switch (lhs, rhs) {
    case (.notRequested, .notRequested): return true
    case let (.isLoading(lhsV), .isLoading(rhsV)): return lhsV == rhsV
    case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
    case let (.failed(lhsID, _), .failed(rhsID, _)):
      return lhsID == rhsID
    default: return false
    }
  }
}

extension View {
  public func combineLoading(_ bindings: Binding<Bool>...) -> Binding<Bool> {
    return Binding {
      bindings.contains(where: { $0.wrappedValue })
    } set: { _ in }
  }
}
