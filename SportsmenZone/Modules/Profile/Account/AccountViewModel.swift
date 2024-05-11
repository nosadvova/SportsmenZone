//
//  AccountViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 08.05.2024.
//

import Foundation
import Models
import CacheProvider

@MainActor
class AccountViewModel: ObservableObject {
    @Published var personalInformation: PersonalInformation?
    @Published var gym: Gym?
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    
    let globalDataStorage: GlobalDataStorage
    let cacheProvider: CacheProvider
    
    init(
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared,
        cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self)
    ) {
        self.globalDataStorage = globalDataStorage
        self.cacheProvider = cacheProvider
        
        initialLoad()
    }
    
    private func initialLoad() {
        Task {
            guard let personalInformation = await globalDataStorage.user?.personalInformation else { return }
            self.personalInformation = personalInformation
            firstName = personalInformation.firstName ?? ""
            lastName = personalInformation.lastName ?? ""
            email = personalInformation.email ?? ""
            
            guard let gym = await globalDataStorage.gym else { return }
            print(gym)
            self.gym = gym
        }
    }
    
    func clearAuthToken() {
        cacheProvider.removeSensitiveValue(forKey: Constants.StorageKey.authToken)
    }
}