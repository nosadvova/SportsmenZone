//
//  SearchViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 11.05.2024.
//

import Foundation
import Models
import SportUI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var gyms: [Gym]?
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    
    let networkService: GymAPI
    let globalDataStorage: GlobalDataStorage
    
    init(
        networkService: GymAPI = RealGymAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.networkService = networkService
        self.globalDataStorage = globalDataStorage
        
        getAllGyms()
    }
    
    func getAllGyms() {
        Task {
            requestLoadable.loading()
            do {
                let allGyms = try await networkService.getAllGyms()
                self.gyms = allGyms.gyms
                requestLoadable = .loaded(true)
            } catch let error as NetworkError {
                requestLoadable = .failed(error)
                print(error.customMessage)
            }
        }
    }
}
