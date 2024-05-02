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
    
    init(cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self))
    {
        self.cacheProvider = cacheProvider
//        getToken()
    }
    
//    func getToken() {
//        let token: SimplifiedAuthToken? = cacheProvider.getSensitiveValue(forKey: Constants.StorageKey.authToken)
//        print(token?.token)
//    }
}
