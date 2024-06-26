//
//  ChooseUserViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 02.04.2024.
//

import Foundation
import Models

@MainActor
final class ChooseUserViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var chosenUserType: UserType?
    @Published var isSportsmenSelected = false
    @Published var isTrainerSelected = false
    
    let globalDataStorage: GlobalDataStorage
    
    init(globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared) {
        self.globalDataStorage = globalDataStorage
        
        storeData()
    }
    
    func storeData() {
        Task {
            let personalInformation = await globalDataStorage.personalInformation
            email = personalInformation?.email ?? "no email provided"

            let newPersonalInformation = personalInformation?.copy(userType: chosenUserType)
            await globalDataStorage.setData(personalInformation: newPersonalInformation)
        }
    }
}
