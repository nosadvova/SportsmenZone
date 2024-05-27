//
//  NotificationViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.05.2024.
//

import SwiftUI
import Models
import SportUI

@MainActor
class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationModel] = []
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    @Published var showMessage = (false, "")
    
    let networkService: NotificationAPI
    let globalDataStorage: GlobalDataStorage
    
    init(
        networkService: NotificationAPI = RealNotificationAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.networkService = networkService
        self.globalDataStorage = globalDataStorage
    }
    
    func fetchNotifications() async {
        do {
            requestLoadable.loading()
            let notifications = try await networkService.fetchNotifications()
            self.notifications = notifications
            await globalDataStorage.setData(notifications: notifications)
        } catch {
            requestLoadable = .failed(error)
            let customError = error as! NetworkError
            showMessage = (true, customError.customMessage)
        }
    }
}
