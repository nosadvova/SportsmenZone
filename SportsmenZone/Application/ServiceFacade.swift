//
//  ServiceFacade.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 26.04.2024.
//

import Foundation
import Swinject
import CacheProvider

typealias SessionTokenFetcher = () async throws -> String?

enum ServiceFacade {
    private static let container = Container()
    private static let threadSafeContainer: Resolver = container.synchronize()
    
    static func initializeContainer() {
        
        registerShared(CacheProvider.self) { _ in
          LocalCacheProvider(identifier: Constants.StorageKey.identifier)
        }
        
        registerShared(SessionTokenFetcher.self) { resolver in {
          let cacheProvider = resolver.getService(CacheProvider.self)
//          let authenticationAPI = resolver.getService(AuthenticationAPI.self)

          let authToken: SimplifiedAuthToken? = cacheProvider.getSensitiveValue(
            forKey: Constants.StorageKey.authToken
          )

          guard let authToken = authToken else {
            throw NetworkError.unauthorized
          }

//          if !authToken.isValid {
//            // Let's assume you have a refreshAuthToken method in the AuthenticationAPIProtocol
//            let newAuthToken = try await authenticationAPI.refreshAuthToken(
//              refreshToken: authToken.refreshToken
//            )
//
//            // Update the local cache with the new token
//            try cacheProvider.setSensitiveValue(newAuthToken, forKey: Constants.StorageKey.authToken)
//            return newAuthToken.accessToken
//          }
            return authToken.token
        }
        }
    }
    static func getService<T>(_ type: T.Type, name: String? = nil) -> T {
        return threadSafeContainer.getService(type, name: name)
    }
    
    static func getMockedService<T>(_ type: T.Type) -> T {
        return threadSafeContainer.getService(type, name: String(describing: type.self))
    }
    
    @discardableResult
    private static func registerShared<T>(
        _ type: T.Type,
        name: String? = nil,
        factory: @escaping (Resolver) -> T
    ) -> ServiceEntry<T> {
        return container
            .register(type, name: name, factory: factory)
            .inObjectScope(.container)
    }
    
    @discardableResult
    private static func registerTransient<T>(
        _ type: T.Type,
        name: String? = nil,
        factory: @escaping (Resolver) -> T
    ) -> ServiceEntry<T> {
        return container
            .register(type, name: name, factory: factory)
            .inObjectScope(.transient)
    }
    
    @discardableResult
    private static func registerSharedMock<T>(
        _ type: T.Type,
        factory: @escaping (Resolver) -> T
    ) -> ServiceEntry<T> {
        return registerShared(type, name: String(describing: type.self), factory: factory)
    }
}

fileprivate extension Resolver {
    func getService<T>(_ type: T.Type, name: String? = nil) -> T {
        guard let service = resolve(type, name: name) else {
            fatalError("Service \(type) is NOT registered")
        }
        return service
    }
}
