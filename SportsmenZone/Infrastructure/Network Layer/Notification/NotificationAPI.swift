//
//  NotificationAPI.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.05.2024.
//

import Foundation
import Models

protocol NotificationAPI {
    func createNotification(notification: NotificationModel) async throws
    func fetchNotifications() async throws -> [NotificationModel]
}
