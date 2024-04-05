//
//  ChooseUserViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 02.04.2024.
//

import Foundation

final class ChooseUserViewModel: ObservableObject {
    let globalDataStorage: GlobalDataStorage
    var email: String = ""
    
    init(globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared) {
        self.globalDataStorage = globalDataStorage
        initialData()
    }
    
    func initialData() {
        Task {
            let userEmail = await globalDataStorage.personalInformation
            email = userEmail?.email ?? "none email provided"
            print("user email: ", email)
        }
    }
}
