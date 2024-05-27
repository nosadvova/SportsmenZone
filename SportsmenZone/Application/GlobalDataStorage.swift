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
    private(set) var gym: Gym?
    private(set) var notifications: [NotificationModel]?
    
    static let shared = GlobalDataStorage()
    
    init(
        user: User? = nil,
        training: Training? = nil,
        personalInformation: PersonalInformation? = nil,
        gym: Gym? = nil,
        notifications: [NotificationModel]? = nil
    ) {
        self.user = user
        self.training = training
        self.personalInformation = personalInformation
        self.gym = gym
        self.notifications = notifications
    }
    
    func setData(
        user: User? = nil,
        training: Training? = nil,
        personalInformation: PersonalInformation? = nil,
        gym: Gym? = nil,
        notifications: [NotificationModel]? = nil
    ) {
        if let user { self.user = user }
        if let training { self.training = training }
        if let personalInformation { self.personalInformation = personalInformation }
        if let gym { self.gym = gym }
        if let notifications { self.notifications = notifications }
    }
    
    func resetPassword() {
        personalInformation?.password = nil
    }
    
    func reset() {
        user = nil
        training = nil
        personalInformation = nil
        gym = nil
        notifications = nil
    }
}
