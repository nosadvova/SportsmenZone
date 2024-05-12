//
//  AppViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.04.2024.
//

import Foundation
import CacheProvider
import Models

class AppViewModel: ObservableObject {
    private let cacheProvider: CacheProvider
    private let userAPI: UserAPI
    private let globalDataStorage: GlobalDataStorage
    
    init(
        cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self),
        userAPI: UserAPI = RealUserAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.cacheProvider = cacheProvider
        self.userAPI = userAPI
        self.globalDataStorage = globalDataStorage
        
//        let authToken: SimplifiedAuthToken? = cacheProvider.getSensitiveValue(forKey: Constants.StorageKey.authToken)
//        print(authToken?.token ?? "no auth token provided")
    }
    
    var isUserAuth: Bool {
        let authToken: SimplifiedAuthToken? = cacheProvider.getSensitiveValue(forKey: Constants.StorageKey.authToken)
        guard let authToken = authToken, authToken.isValid else {
            return false
        }
        return true
    }    
    
    func getUser() {
        Task {
            if let user = await globalDataStorage.user {
                await globalDataStorage.setData(user: user)
                return
            }
            
            do {
                let user = try await userAPI.getUser()
                await globalDataStorage.setData(user: user)
                await globalDataStorage.setData(personalInformation: user.personalInformation)
//                print("User fetched: \(user)")
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
}
