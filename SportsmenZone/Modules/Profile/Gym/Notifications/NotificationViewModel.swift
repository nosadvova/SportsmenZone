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
    @Published var notification: NotificationModel?
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var type: NotificationType? = nil
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    @Published var showMessage = (false, "")
    @Published var showNotificationScreen = false
    @Published var user: User?
    @Published var gym: Gym?
    
    let networkService: NotificationAPI
    let globalDataStorage: GlobalDataStorage
    
    init(
        networkService: NotificationAPI = RealNotificationAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.networkService = networkService
        self.globalDataStorage = globalDataStorage
        setupVariables()
    }
    
    private func setupVariables() {
        Task {
            user = await globalDataStorage.user
            gym = await globalDataStorage.gym
        }
    }
    
    var isOwner: Bool {
        return user?.personalInformation?.userType == .Trainer
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
            if let notifications = await globalDataStorage.notifications {
                self.notifications = notifications
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
    
    func deleteNotification(id: String) {
        if let index = notifications?.firstIndex(where: { $0.id == id }) {
            Task {
                do {
                    _ = try await networkService.deleteNotification(id: id)
                    notifications?.remove(at: index)
                    showNotificationScreen = false
                } catch let error as NetworkError {
                    showMessage = (true, error.customMessage)
                }
            }
        }
    }
}

extension NotificationViewModel {
    var notificationTypeLabel: String {
        let label: String
        
        if let type {
            label = type.displayName
        } else {
            label = S.Notifications.chooseNotificationType
        }
        return label
    }
}
