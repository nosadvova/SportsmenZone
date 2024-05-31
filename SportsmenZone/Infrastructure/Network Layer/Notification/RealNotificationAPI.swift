//
//  RealNotificationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.05.2024.
//

import Foundation
import Models

class RealNotificationAPI: NetworkService, NotificationAPI {
    func createNotification(notification: NotificationModel) async throws {
        return try await sendRequest(route: NotificationNetworkRoute.createNotification(notification: notification))
    }
    
    func fetchNotifications() async throws -> [NotificationModel] {
        return try await sendRequest(route: NotificationNetworkRoute.fetchNotifications)
    }
    
    func deleteNotification(id: String) async throws {
        return try await sendRequest(route: NotificationNetworkRoute.deleteNotification(id: id))
    }
}
