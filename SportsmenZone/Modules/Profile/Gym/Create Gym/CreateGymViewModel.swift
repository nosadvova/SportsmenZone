//
//  CreateGymViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 03.05.2024.
//

import Foundation
import Combine
import Models

@MainActor
class CreateGymViewModel: ObservableObject {
    @Published var name: String = "Test prvate gym"
    @Published var description: String = "Cool gym"
    @Published var city: String = "Lviv"
    @Published var district: String = "Levandivka"
    @Published var street: String = "Franceska"
    @Published var buildingNumber: String = "21"
    @Published var type: [SportType] = [.basketball]
    
    @Published var showMessage: (Bool, String) = (false, "")
    @Published var isFormValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    let networkService: GymAPI
    let globalDataStorage: GlobalDataStorage
    
    init(
        networkService: GymAPI = RealGymAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.networkService = networkService
        self.globalDataStorage = globalDataStorage
        setupBindings()
    }
    
    func pickType(sportType: SportType) {
        if let index = type.firstIndex(of: sportType) {
            type.remove(at: index)
        } else {
            type.append(sportType)
        }
    }
    
    var sportTypeLabel: String {
        let label: String
        
        if type.isEmpty {
            label = S.Gym.chooseSportTypes
        } else if type.count == 1 {
            label = type.first?.displayName ?? ""
        } else {
            label = type.map { $0.displayName }.joined(separator: ", ")
        }
        return label
    }
    
    func createNewGym() {
        Task {
            do {
                guard let trainerID = await globalDataStorage.user?.id else { return }
                let gym = Gym(name: name, description: description, location: Location(city: city, district: district, street: street, buildingNumber: buildingNumber), type: type, trainerID: trainerID)
                _ = try await networkService.createGym(gymInformation: gym)
            } catch let error as NetworkError {
                print(error.customMessage)
                showMessage = (true, error.customMessage)
            }
        }
    }
    
    private func setupBindings() {
        var textFieldsPublisher: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest3($name, $description, $type)
                .map { name, description, type in
                    guard !name.isEmpty && !description.isEmpty && !type.isEmpty else { return false }
                    return true
                }
                .eraseToAnyPublisher()
        }
        
        var addressFieldsPublisher: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest4($city, $district, $street, $buildingNumber)
                .map { city, district, street, buildingNumber in
                    guard !city.isEmpty && !district.isEmpty && !street.isEmpty && !buildingNumber.isEmpty else { return false }
                    return true
                }
                .eraseToAnyPublisher()
        }
        
        Publishers.CombineLatest(textFieldsPublisher, addressFieldsPublisher)
            .map { textFieldsValid, addressFieldsValid in
                guard textFieldsValid && addressFieldsValid else { return false }
                return true
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
}
