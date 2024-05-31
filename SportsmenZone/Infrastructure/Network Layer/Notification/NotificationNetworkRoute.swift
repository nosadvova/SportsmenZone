//
//  NotificationNetworkRoute.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 27.05.2024.
//

import Foundation
import Models

enum NotificationNetworkRoute {
    case createNotification(notification: NotificationModel)
    case fetchNotifications
    case deleteNotification(id: String)
}

extension NotificationNetworkRoute: ServerRoute {
    var path: String {
        switch self {
        case .createNotification:
            "/notifications"
        case .fetchNotifications:
            "/notifications"
        case .deleteNotification(let id):
            "/notifications/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createNotification:
            return .post
        case .fetchNotifications:
            return .get
        case .deleteNotification:
            return .delete
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .createNotification(let notification):
            return notification.requestBody()
        case .fetchNotifications:
            return nil
        case .deleteNotification:
            return nil
        }
    }
}
