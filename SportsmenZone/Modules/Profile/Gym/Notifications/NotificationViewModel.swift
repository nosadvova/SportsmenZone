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
    @Published var notifications: [NotificationModel]?
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    @Published var showMessage = (false, "")
    
//    var user: User?
    let networkService: NotificationAPI
    let globalDataStorage: GlobalDataStorage
    
    init(
//        user: User? = nil,
        networkService: NotificationAPI = RealNotificationAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
//        self.user = user
        self.networkService = networkService
        self.globalDataStorage = globalDataStorage
    }
    
    func createNotification(notification: NotificationModel) {
        Task {
            do {
                _ = try await networkService.createNotification(notification: notification)
                notifications?.append(notification)
                await globalDataStorage.setData(notifications: notifications)
            } catch let error as NetworkError {
                showMessage = (true, error.customMessage)
            }
        }
    }
    
    func fetchNotifications() async {
        do {
            if let localNotifications = await globalDataStorage.notifications {
                self.notifications = localNotifications
                return
            }
            
            requestLoadable.loading()
            let notificationResponse = try await networkService.fetchNotifications()
            self.notifications = notificationResponse
            await globalDataStorage.setData(notifications: notifications)
        } catch {
            requestLoadable = .failed(error)
            let customError = error as! NetworkError
            print("Notification error: ", customError)
            showMessage = (true, customError.customMessage)
        }
    }
    
    func deleteNotification(offset: IndexSet) {
        offset.forEach { index in
            let notification = notifications?[index]
            Task {
                do {
                    _ = try await networkService.deleteNotification(id: notification?.id ?? "")
                    notifications?.remove(at: index)
                } catch let error as NetworkError {
                    showMessage = (true, error.customMessage)
                }
            }
        }
    }
}
