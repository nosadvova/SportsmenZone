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
    
    var originalFirstName: String = ""
    var originalLastName: String = ""
    var originalEmail: String = ""
    
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
    
    var gymImage: String {
        if let image = gym?.type?.first {
            return image.image
        }
        return "figure.run"
    }
    
    private func initialLoad() {
        Task {
            guard let personalInformation = await globalDataStorage.user?.personalInformation else { return }
            self.personalInformation = personalInformation
            firstName = personalInformation.firstName ?? ""
            lastName = personalInformation.lastName ?? ""
            email = personalInformation.email ?? ""
            
            originalFirstName = firstName
            originalLastName = lastName
            originalEmail = email
            
            guard let gym = await globalDataStorage.gym else { return }
            self.gym = gym
        }
    }
    
    func saveChanges() {
        Task {
            personalInformation?.firstName = firstName
            personalInformation?.lastName = lastName
            personalInformation?.email = email
            
            await globalDataStorage.setData(personalInformation: personalInformation)
        }
    }
    
    func clearAuthToken() async {
        cacheProvider.removeSensitiveValue(forKey: Constants.StorageKey.authToken)
        await globalDataStorage.reset()
    }
    
    func checkChanges(newValue: String, oldValue: String) -> Bool {
        let trimmedNewValue = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmedNewValue != oldValue && !trimmedNewValue.isEmpty ? true : false
    }
}
