//
//  GymViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import Models
import CacheProvider

@MainActor
final class GymViewModel: ObservableObject {
    @Published var sportsmen: [User] = MockData.users
    @Published var trainings: [Training] = MockData.trainings
    @Published var gym: Gym?
    
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
    }
    
    func getGym() {
        Task {
            do {
                let id = await globalDataStorage.personalInformation?.gym
                guard let gymID = id else {
                    gym = nil
                    return
                }
                gym = try await networkService.getGym(id: gymID)
            }
        }
    }
}
