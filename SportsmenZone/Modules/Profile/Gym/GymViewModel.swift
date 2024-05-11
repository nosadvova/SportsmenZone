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
    
    let cacheProvider: CacheProvider
    let globalDataStorage: GlobalDataStorage
    let networkService: GymAPI
    
    init(
        cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared,
        networkService: GymAPI = RealGymAPI()
    )
    {
        self.cacheProvider = cacheProvider
        self.globalDataStorage = globalDataStorage
        self.networkService = networkService  
        
        setUser()
    }
    
    func getGym() {
        requestLoadable.loading()
        Task {
            do {
                guard let gymID = await globalDataStorage.personalInformation?.gym else {
                    gym = nil
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
    
    private func setUser() {
        Task {
            guard let currentUser = await globalDataStorage.user else { return }
            user = currentUser
        }
    }
}
