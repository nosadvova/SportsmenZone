//
//  NotificationViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.05.2024.
//

import SwiftUI
import Models

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationModel]
    
    init(notifications: [NotificationModel]) {
        self.notifications = notifications
    }
}
