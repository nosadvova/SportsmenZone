//
//  GymViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 06.03.2024.
//

import SwiftUI
import Models
import CacheProvider

final class GymViewModel: ObservableObject {
    @Published var sportsmen: [User] = MockData.users
    @Published var trainings: [Training] = MockData.trainings
    @Published var gym: Gym?
    
    let cacheProvider: CacheProvider
    let globalDataStorage: GlobalDataStorage
    
    init(
        cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    )
    {
        self.cacheProvider = cacheProvider
        self.globalDataStorage = globalDataStorage
    }
    
    func getGym() async {
        let personalInformation = await globalDataStorage.user?.personalInformation
        gym = personalInformation?.gym
    }
}
