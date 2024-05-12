//
//  SearchViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 11.05.2024.
//

import Foundation
import Models

@MainActor
class SearchViewModel: ObservableObject {
    @Published var gyms: [Gym]?
    
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
            do {
                let gyms = try await networkService.getAllGyms()
                self.gyms = gyms
                print(gyms.count)
            } catch let error as NetworkError {
                print(error.customMessage)
            }
        }
    }
}
