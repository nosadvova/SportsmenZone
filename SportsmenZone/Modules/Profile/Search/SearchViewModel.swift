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
    @Published var typesFilter: [SportType] = []
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    @Published var showAddress = false
    
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
    
    func getGymLocation(gym: Gym?) -> String {
        if let city = gym?.location?.city, let district = gym?.location?.district {
            return "\(city), \(district)"
        }
        return "No location provided"
    }

    func getGymImage(gym: Gym?) -> String {
        if let image = gym?.type?.first {
            return image.image
        }
        return "figure.run"
    }
    
    func pickTypeFilter(sportType: SportType) {
        if let index = typesFilter.firstIndex(of: sportType) {
            typesFilter.remove(at: index)
        } else {
            typesFilter.append(sportType)
        }
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
