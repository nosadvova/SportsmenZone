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
        globalDataStorage: GlobalDataStorage = GlobalDataStorage()
    ) {
        self.cacheProvider = cacheProvider
        self.userAPI = userAPI
        self.globalDataStorage = globalDataStorage
    }
    
    var isUserAuth: Bool {
        let authToken: SimplifiedAuthToken? = cacheProvider.getSensitiveValue(forKey: Constants.StorageKey.authToken)
        guard let authToken = authToken, authToken.isValid else {
            return false
        }
        return true
    }
    
    func getUser() async {
        do {
            let user = try await userAPI.getUser()
            print(user)
            await globalDataStorage.setData(user: user)
        } catch {
            print("Error: \(error)")
        }
    }
}
