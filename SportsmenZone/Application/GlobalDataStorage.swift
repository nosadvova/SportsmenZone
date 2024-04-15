//
//  GlobalDataStorage.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 01.04.2024.
//

import Foundation
import Models

actor GlobalDataStorage {
    private(set) var user: User?
    private(set) var training: Training?
    private(set) var personalInformation: PersonalInformation?
    
    static let shared = GlobalDataStorage()
    
    init(
        user: User? = nil,
        training: Training? = nil,
        personalInformation: PersonalInformation? = nil
    ) {
        self.user = user
        self.training = training
        self.personalInformation = personalInformation
    }
    
    func setData(
        user: User? = nil,
        training: Training? = nil,
        personalInformation: PersonalInformation? = nil
    ) {
        if let user { self.user = user }
        if let training { self.training = training }
        if let personalInformation { self.personalInformation = personalInformation }
    }
    
    func resetPassword() {
        personalInformation?.password = nil
    }
    
    func reset() {
        user = nil
        training = nil
        personalInformation = nil
    }
}
