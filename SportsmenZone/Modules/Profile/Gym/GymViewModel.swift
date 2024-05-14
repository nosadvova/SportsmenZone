//
//  GymViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import Models
import CacheProvider
import SportUI

@MainActor
final class GymViewModel: ObservableObject {
    @Published var sportsmen: [User] = MockData.users
    @Published var trainings: [Training] = MockData.trainings
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    @Published var gym: Gym?
    @Published var user: User?
    let isHomeScreen: Bool?
    
    let cacheProvider: CacheProvider
    let globalDataStorage: GlobalDataStorage
    let networkService: GymAPI
    
    init(
        cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared,
        networkService: GymAPI = RealGymAPI(),
        gym: Gym? = nil,
        isHomeScreen: Bool? = nil
    )
    {
        self.cacheProvider = cacheProvider
        self.globalDataStorage = globalDataStorage
        self.networkService = networkService
        self.gym = gym
        self.isHomeScreen = isHomeScreen
        
        getGym()
        setUser()
    }
    
    var isOwner: Bool {
        guard let userType = user?.personalInformation?.userType,
              userType == UserType.Trainer.rawValue,
              let userGymId = user?.personalInformation?.gym,
              let currentGymId = gym?.id,
              userGymId == currentGymId else {
            return false
        }
        return true
    }
    
    func getGym() {
        if gym == nil {
            Task {
                if let storedGym = await globalDataStorage.gym {
                    gym = storedGym
                    requestLoadable = .loaded(true)
                    return
                }
                
                requestLoadable.loading()
                do {
                    guard let gymID = await globalDataStorage.personalInformation?.gym else {
                        gym = nil
                        requestLoadable = .notRequested
                        return
                    }
                    gym = try await networkService.getGym(id: gymID)
                    await globalDataStorage.setData(gym: gym)
                    requestLoadable = .loaded(true)
                } catch {
                    requestLoadable = .failed(error)
                }
            }
        }
    }
    
    private func setUser() {
        Task {
            guard let currentUser = await globalDataStorage.user else { return }
            user = currentUser
        }
    }
}
